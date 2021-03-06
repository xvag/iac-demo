
module "c-vm" {
  count      = length(var.vm.controller.ip)
  source     = "./modules/vm"
  vm_name    = "${var.vm.controller.name}-${count.index}"
  vm_zone    = var.vm.controller.zone
  vm_machine = var.vm.controller.machine
  vm_image   = var.vm.controller.image
  vm_size    = var.vm.controller.size
  vm_ip      = var.vm.controller.ip[count.index]
  vm_tags    = var.vm.controller.tags
  vm_scopes  = var.vm.controller.scopes
  vm_subnet  = module.c-vpc.subnet_name
}

module "w-vm" {
  count      = length(var.vm.worker.ip)
  source     = "./modules/vm"
  vm_name    = "${var.vm.worker.name}-${count.index}"
  vm_zone    = var.vm.worker.zone
  vm_machine = var.vm.worker.machine
  vm_image   = var.vm.worker.image
  vm_size    = var.vm.worker.size
  vm_ip      = var.vm.worker.ip[count.index]
  vm_tags    = var.vm.worker.tags
  vm_scopes  = var.vm.worker.scopes
  vm_subnet  = module.w-vpc.subnet_name
  pod_cidr   = var.pod_cidr[count.index]
}

module "n-vm" {
  count      = length(var.vm.nagios.ip)
  source     = "./modules/vm"
  vm_name    = "${var.vm.nagios.name}-${count.index}"
  vm_zone    = var.vm.nagios.zone
  vm_machine = var.vm.nagios.machine
  vm_image   = var.vm.nagios.image
  vm_size    = var.vm.nagios.size
  vm_ip      = var.vm.nagios.ip[count.index]
  vm_tags    = var.vm.nagios.tags
  vm_scopes  = var.vm.nagios.scopes
  vm_subnet  = module.n-vpc.subnet_name
}
