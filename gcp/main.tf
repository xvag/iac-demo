
###
### Create VPC, Subnet, Firewall Rules and Public-IP
###

resource "google_compute_address" "k8s-ip" {
  name   = "k8s-ip"
  region = var.c-region
}

resource "google_compute_network" "k8s-c-vpc" {
  name = "k8s-c-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "k8s-w-vpc" {
  name = "k8s-w-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "k8s-c-subnet" {
  name          = "k8s-c-subnet"
  region        = var.c-region
  ip_cidr_range = var.c-subnet
  network       = google_compute_network.k8s-c-vpc.id
}

resource "google_compute_subnetwork" "k8s-w-subnet" {
  name          = "k8s-w-subnet"
  region        = var.w-region
  ip_cidr_range = var.w-subnet
  network       = google_compute_network.k8s-w-vpc.id
}

resource "google_compute_firewall" "k8s-fw-c-in" {
  name     = "k8s-fw-c-in"
  network  = "k8s-c-vpc"
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["${var.c-subnet}","${var.pod-cidr-range}"]
  depends_on = [
    google_compute_subnetwork.k8s-c-subnet
  ]
}

resource "google_compute_firewall" "k8s-fw-c-ex" {
  name     = "k8s-fw-c-ex"
  network  = "k8s-c-vpc"
  allow {
    protocol = "tcp"
    ports    = ["22","6443","32000","32073","30659","30000","30001"]
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
  depends_on = [
    google_compute_subnetwork.k8s-c-subnet
  ]
}

resource "google_compute_firewall" "k8s-fw-w-in" {
  name     = "k8s-fw-w-in"
  network  = "k8s-w-vpc"
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["${var.w-subnet}","${var.pod-cidr-range}"]
  depends_on = [
    google_compute_subnetwork.k8s-w-subnet
  ]
}

resource "google_compute_firewall" "k8s-fw-w-ex" {
  name     = "k8s-fw-w-ex"
  network  = "k8s-w-vpc"
  allow {
    protocol = "tcp"
    ports    = ["22","6443","32000","32073","30659","30000","30001"]
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
  depends_on = [
    google_compute_subnetwork.k8s-w-subnet
  ]
}

resource "google_compute_firewall" "k8s-fw-allow-health-check" {
  name    = "k8s-fw-allow-health-check"
  network = "k8s-c-vpc"
  allow {
    protocol = "tcp"
  }
  source_ranges  = ["209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16"]
  depends_on = [
    google_compute_subnetwork.k8s-c-subnet
  ]
}

resource "google_compute_network_peering" "c-w" {
  name         = "c-w"
  network      = google_compute_network.k8s-c-vpc.self_link
  peer_network = google_compute_network.k8s-w-vpc.self_link
}

resource "google_compute_network_peering" "w-c" {
  name         = "w-c"
  network      = google_compute_network.k8s-w-vpc.self_link
  peer_network = google_compute_network.k8s-c-vpc.self_link
}

###
### Create Forwarding from Public-IP, Controllers' Health-Check and Cluster's pods Routing
###

resource "google_compute_http_health_check" "k8s-health-check" {
  name         = "k8s-health-check"
  host         = "kubernetes.default.svc.cluster.local"
  request_path = "/healthz"
}

resource "google_compute_target_pool" "k8s-target-pool" {
  name = "k8s-target-pool"
  instances = [
    "${var.c-zone}/${var.controller-name[0]}",
    #"${var.c-zone}/${var.controller-name[1]}",
  ]
  health_checks = [
    google_compute_http_health_check.k8s-health-check.name,
  ]
}

resource "google_compute_forwarding_rule" "k8s-forwarding-rule" {
  name       = "k8s-forwarding-rule"
  ip_address = google_compute_address.k8s-ip.address
  port_range = "6443-6443"
  region     = var.c-region
  target     = google_compute_target_pool.k8s-target-pool.id
  depends_on = [
    google_compute_address.k8s-ip,
    google_compute_target_pool.k8s-target-pool
  ]
}

resource "google_compute_route" "k8s-w-route" {
  count       = var.worker-no

  name        = "k8s-route-pods-worker-${count.index}"
  dest_range  = var.pod-cidr[count.index]
  network     = "k8s-w-vpc"
  next_hop_ip = var.worker-ip[count.index]
  depends_on = [
    google_compute_subnetwork.k8s-w-subnet
  ]
}

resource "google_compute_route" "k8s-c-route" {
  name        = "k8s-route-pods-worker-2"
  dest_range  = var.pod-cidr[2]
  network     = "k8s-c-vpc"
  next_hop_ip = var.worker-ip[2]
  depends_on = [
    google_compute_subnetwork.k8s-c-subnet
  ]
}

###
### Create the VMs
###

resource "google_compute_instance" "controller" {
  count = var.controller-no

  name                      = var.controller-name[count.index]
  machine_type              = var.c-machine
  zone                      = var.c-zone
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = ["k8s", "controller"]
  boot_disk {
    initialize_params {
      image = var.c-image
      size  = var.c-size
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s-c-subnet.self_link
    network_ip = var.controller-ip[count.index]
    access_config {
    }
  }
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_key}"
    pod-cidr = var.pod-cidr[2]
  }
  depends_on = [
    google_compute_subnetwork.k8s-c-subnet
  ]
}

resource "google_compute_instance" "worker" {
  count = var.worker-no

  name                      = var.worker-name[count.index]
  machine_type              = var.w-machine
  zone                      = var.w-zone
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = ["k8s", "worker"]
  boot_disk {
    initialize_params {
      image = var.w-image
      size  = var.w-size
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s-w-subnet.self_link
    network_ip = var.worker-ip[count.index]
    access_config {
    }
  }
  service_account{
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_key}"
    pod-cidr = var.pod-cidr[count.index]
  }
  depends_on = [
    google_compute_subnetwork.k8s-w-subnet
  ]
}
