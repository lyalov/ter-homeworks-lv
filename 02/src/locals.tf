locals {

  vm_web_name = "${var.vpc_name}-${var.vm_web_zone}-web" 
  vm_db_name  = "${var.vpc_name}-${var.vm_db_zone}-db"

  ssh_public_key = file("${path.module}/config/ssh_key.pub")
 
  vm_metadata = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }
}