
resource "google_compute_address" "k8s-ip" {
  name   = "k8s-ip"
  region = var.region
}

resource "google_compute_network" "k8s-vpc" {
  name = "k8s-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "k8s-subnet" {
  name          = "k8s-subnet"
  region        = var.region
  ip_cidr_range = var.subnet
  network       = google_compute_network.k8s-vpc.id
}

resource "google_compute_firewall" "k8s-fw-in" {
  name     = "k8s-fw-in"
  network  = "k8s-vpc"
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["${var.subnet}","${var.pod-cidr-range}"]
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}

resource "google_compute_firewall" "k8s-fw-ex" {
  name     = "k8s-fw-ex"
  network  = "k8s-vpc"
  allow {
    protocol = "tcp"
    ports    = ["22","6443"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}

resource "google_compute_instance" "controller" {
  count = controller-no

  name                      = var.controller-name[count.index]
  machine_type              = var.machine
  zone                      = var.zone
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = ["k8s", "controller"]
  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.self_link
    network_ip = var.controller-ip[count.index]
    access_config {
    }
  }
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_key}"
  }
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}

resource "google_compute_instance" "worker" {
  count = worker-no

  name                      = var.worker-name[count.index]
  machine_type              = var.machine
  zone                      = var.zone
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = ["k8s", "worker"]
  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.self_link
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
    google_compute_subnetwork.k8s-subnet
  ]
}
