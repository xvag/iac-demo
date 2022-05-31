project = "active-defender-350709"
region  = "europe-west4"
zone    = "europe-west4-a"
subnet  = "10.240.0.0/24"
machine = "e2-standard-2"
image   = "ubuntu-os-cloud/ubuntu-2004-lts"
size    = "20"

controller-no   = 2
controller-name = ["controller-0","controller-1"]
controller-ip   = ["10.240.0.10","10.240.0.11"]

worker-no      = 2
worker-name    = ["worker-0","worker-1"]
worker-ip      = ["10.240.0.20","10.240.0.21"]
pod-cidr       = ["10.200.0.0/24","10.200.1.0/24"]

pod-cidr-range = "10.200.0.0/16"
