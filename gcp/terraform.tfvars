###
### VPC/Subnets
###

vpc = {
  "controller" = {
    name     = "controller"
    region   = "europe-west4"
    cidr     = "10.240.0.0/24"
  },
  "worker" = {
    name     = "worker"
    region   = "us-central1"
    cidr     = "10.250.0.0/24"
  },
  "nagios" = {
    name     = "nagios"
    region   = "asia-east1"
    cidr     = "10.200.0.0/24"
  }
}

###
### Firewalls
###

fw = {
  in_cluster = {
    "tcp" = {
      ports    = []
    }
    "udp" = {
      ports    = []
    }
    "icmp" = {
      ports    = []
    }
  },
  controller_vpc = {
    "tcp" = {
      ports    = ["22","6443","5666"]
    }
    "icmp" = {
      ports    = []
    }
  },
  worker_vpc = {
    "tcp" = {
      ports    = ["22","5666","32000","32010","32001","32002","32003","31000","31001","30000","30001","30080"]
    }
    "icmp" = {
      ports    = []
    }
  },
  allow_health_checks = {
    "tcp" = {
      ports    = []
    }
  },
  nagios_vpc = {
    "tcp" = {
      ports    = ["22","443","80"]
    }
    "icmp" = {
      ports    = []
    }
  }
}

###
### VMs
### Tip: The amount of IPs declared will define the amount of instances to be created
###

vm = {
  "controller" = {
    name    = "controller"
    zone    = "europe-west4-a"
    machine = "e2-standard-2"
    image   = "ubuntu-os-cloud/ubuntu-2004-lts"
    size    = "200"
    ip      = ["10.240.0.10","10.240.0.11"]
    tags    = ["k8s", "controller"]
    scopes  = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  },
  "worker" = {
    name    = "worker"
    zone    = "us-central1-c"
    machine = "e2-standard-2"
    image   = "ubuntu-os-cloud/ubuntu-2004-lts"
    size    = "200"
    ip      = ["10.250.0.20","10.250.0.21"]
    tags    = ["k8s", "worker"]
    scopes  = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  },
  "nagios" = {
    name    = "nagios"
    zone    = "asia-east1-b"
    machine = "e2-standard-2"
    image   = "centos-cloud/centos-7"
    size    = "200"
    ip      = ["10.200.0.10"]
    tags    = ["nagios"]
    scopes  = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}

###
### Target Pool of the Controllers for the Health Checks
###

target_pool     = [
                    "europe-west4-a/controller-0",
                    "europe-west4-a/controller-1",
                  ]

###
### Kubernetes Variables
###

service-cluster-ip-range = "10.32.0.0/24"

### Apply one POD-CIDR for every Worker instance
pod_cidr_range = "10.200.0.0/16"
pod_cidr       = ["10.200.0.0/24","10.200.1.0/24"]
