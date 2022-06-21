###
### VM variables
### The number of IPs have to match the number of instances (no)
###

vpc = {
  "controller" = {
    no      = 2
    name    = "controller"
    region  = "europe-west4"
    zone    = "europe-west4-a"
    machine = "e2-standard-2"
    image   = "ubuntu-os-cloud/ubuntu-2004-lts"
    size    = "200"
    subnet  = "10.240.0.0/24"
    ip      = ["10.240.0.10","10.240.0.11"]
    fw      = ["22","6443","5666"]
  },
  "worker" = {
    no      = 2
    name    = "worker"
    region  = "us-central1"
    zone    = "us-central1-c"
    machine = "e2-standard-2"
    image   = "ubuntu-os-cloud/ubuntu-2004-lts"
    size    = "200"
    subnet  = "10.250.0.0/24"
    ip      = ["10.250.0.20","10.250.0.21"]
    fw      = ["22","32000","32010","32001","32002","32003","31000","31001","30000","30001","30080"]
  },
  "nagios" = {
    no      = 1
    name    = "nagios"
    region  = "us-central2"
    zone    = "us-central2-a"
    machine = "e2-standard-2"
    image   = "centos-cloud/centos-7"
    size    = "200"
    subnet  = "10.200.0.0/24"
    ip      = ["10.200.0.10"]
    fw      = ["22","443","80"]
  }
}

###
### Kubernetes Cluster IP range
###

service-cluster-ip-range = "10.32.0.0/24"

###
### Pod Network variables
### Apply one POD-CIDR for every Worker instance
###

pod-cidr-range = "10.200.0.0/16"
pod-cidr       = ["10.200.0.0/24","10.200.1.0/24"]

###
### Target Pool of the Controllers for the Health Checks
###

target-pool     = [
                    "europe-west4-a/controller-0",
                    "europe-west4-a/controller-1",
                  ]
