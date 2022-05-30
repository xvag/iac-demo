terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = var.gcp_creds
  project     = var.project
}

resource "google_compute_network" "k8s-vpc" {
  name = "k8s-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "k8s-subnet" {
  name          = "k8s-subnet"
  region        = "europe-west4"
  ip_cidr_range = "10.240.0.0/24"
  network       = google_compute_network.k8s-vpc.id
}

resource "google_compute_firewall" "k8s-fw" {
  name     = "k8s-fw"
  network  = "k8s-vpc"
  allow {
    protocol = "all"
  }
  source_ranges = [
    "0.0.0.0/0"
  ]
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}

resource "google_compute_address" "k8s-ip" {
  name   = "k8s-ip"
  region = "europe-west4"
}

resource "google_compute_instance" "master-vm" {
  count = 3

  name                      = "master-vm-${count.index}"
  machine_type              = "e2-standard-2"
  region                    = "europe-west4"
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = ["k8s", "master"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = "20"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.self_link
    network_ip = "10.240.0.1${count.index}"
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

resource "google_compute_instance" "worker-vm" {
  count = 3
  
  name                      = "worker-vm-${count.index}"
  machine_type              = "e2-standard-2"
  region                    = "europe-west4"
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = ["k8s", "worker"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = "20"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.self_link
    network_ip = "10.240.0.2${count.index}"
    access_config {
    }
  }
  service_account{
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  metadata = {
    pod-cidr = "10.200.${count.index}.0/24"
    ssh-keys = "${var.ssh_user}:${var.ssh_key}"
  }
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}
