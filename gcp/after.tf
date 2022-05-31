resource "google_compute_firewall" "k8s-fw-allow-health-check" {
  name    = "k8s-fw-allow-health-check"
  network = "k8s-vpc"
  allow {
    protocol = "tcp"
  }
  source_ranges  = ["209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16"]
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}

resource "google_compute_http_health_check" "k8s-health-check" {
  name         = "k8s-health-check"
  host         = "kubernetes.default.svc.cluster.local"
  request_path = "/healthz"
}

resource "google_compute_target_pool" "k8s-target-pool" {
  name = "k8s-target-pool"
  instances = [
    "${var.zone}/${var.controller-name[0]}",
    "${var.zone}/${var.controller-name[1]}",
  ]
  health_checks = [
    google_compute_http_health_check.k8s-health-check.name,
  ]
}

resource "google_compute_forwarding_rule" "k8s-forwarding-rule" {
  name       = "k8s-forwarding-rule"
  ip_address = "34.91.239.68"
  port_range = "6443-6443"
  region     = var.region
  target     = google_compute_target_pool.k8s-target-pool.id
}

resource "google_compute_route" "k8s-route" {
  count       = var.worker-no

  name        = "k8s-route-10-200-${count.index}-0-24"
  dest_range  = var.pod-cidr[count.index]
  network     = "k8s-vpc"
  next_hop_ip = "10.240.0.2${count.index}"
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}
