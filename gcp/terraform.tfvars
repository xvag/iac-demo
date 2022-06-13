###
### Common variables
###

c-region  = "europe-west4"
c-zone    = "europe-west4-a"
c-subnet  = "10.240.0.0/24"
c-machine = "custom-4-8192"
c-image   = "ubuntu-os-cloud/ubuntu-2004-lts"
c-size    = "20"

w-region  = "europe-north1"
w-zone    = "europe-north1-c"
w-subnet  = "10.250.0.0/24"
w-machine = "custom-4-8192"
w-image   = "ubuntu-os-cloud/ubuntu-2004-lts"
w-size    = "20"

###
### Controller variables
###

controller-no   = 1                                # Number of Controllers
controller-name = ["controller-0"]  # Names
controller-ip   = ["10.240.0.10"]    # Internal IP
# controller-name = ["controller-0","controller-1"]  # Names
# controller-ip   = ["10.240.0.10","10.240.0.11"]    # Internal IP

###
### Worker variables
###

worker-no      = 2                                 # Number of Workers
worker-name    = ["worker-0","worker-1"]           # Names
worker-ip      = ["10.250.0.20","10.250.0.21","10.240.0.10"]     # Internal IP
pod-cidr       = ["10.200.0.0/24","10.200.1.0/24","10.200.2.0/24"] # Pod Subnet

pod-cidr-range = "10.200.0.0/16"                   # Pod Subnet range
