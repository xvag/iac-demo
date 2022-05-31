###
### Common variables
###

project = "active-defender-350709"
region  = "europe-west4"
zone    = "europe-west4-a"
subnet  = "10.240.0.0/24"
machine = "e2-standard-2"
image   = "ubuntu-os-cloud/ubuntu-2004-lts"
size    = "20"

###
### Controller variables
###

controller-no   = 2                                # Number of Controllers
controller-name = ["controller-0","controller-1"]  # Names
controller-ip   = ["10.240.0.10","10.240.0.11"]    # Internal IP

###
### Worker variables
###

worker-no      = 2                                 # Number of Workers
worker-name    = ["worker-0","worker-1"]           # Names
worker-ip      = ["10.240.0.20","10.240.0.21"]     # Internal IP
pod-cidr       = ["10.200.0.0/24","10.200.1.0/24"] # Pod Subnet

pod-cidr-range = "10.200.0.0/16"                   # Pod Subnet range
