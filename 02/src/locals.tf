locals {

  vm_web_name = "netology-develop-platform-web"
  vm_db_name  = "netology-develop-platform-db"

  ssh_public_key = file("${path.module}/config/ssh_key.pub")
 
  vm_metadata = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }
}