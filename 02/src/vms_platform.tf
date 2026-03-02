variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  description = "Resources configuration for each VM (web/db)"
}

#variable "vm_metadata" {
#  type        = map(string)
#  description = "Common metadata for all VMs"
#}

variable "vm_web_image_family" {
  type        = string
  description = "Family of the compute image for Web VM"
  default     = "ubuntu-2004-lts"
}

variable "vm_web_name" {
  type        = string
  description = "Name of the Web compute instance"
  default     = "netology-develop-platform-web"
}

variable "vm_web_platform_id" {
  type        = string
  description = "Platform type for the Web instance"
  default     = "standard-v2"
}

variable "vm_web_zone" {
  type        = string
  description = "Zone for Web VM"
  default     = "ru-central1-a"
}

variable "vm_web_disk_type" {
  type        = string
  description = "Type of the boot disk for Web VM"
  default     = "network-hdd"
}

variable "vm_web_preemptible" {
  type        = bool
  description = "Whether the Web instance is preemptible"
  default     = true
}

variable "vm_web_nat" {
  type        = bool
  description = "Enable NAT for public IP for Web VM"
  default     = true
}


# variable "vm_web_cores" { type = number; default = 1 }
# variable "vm_web_memory" { type = number; default = 1 }
# variable "vm_web_core_fraction" { type = number; default = 5 }
# variable "vm_web_serial_port_enable" { type = number; default = 1 }


variable "vm_db_image_family" {
  type        = string
  description = "Family of the compute image for DB VM"
  default     = "ubuntu-2004-lts"
}

variable "vm_db_name" {
  type        = string
  description = "Name of the DB compute instance"
  default     = "netology-develop-platform-db"
}

variable "vm_db_platform_id" {
  type        = string
  description = "Platform type for the DB instance"
  default     = "standard-v2"
}

variable "vm_db_zone" {
  type        = string
  description = "Zone for DB VM"
  default     = "ru-central1-a"
}

variable "vm_db_disk_type" {
  type        = string
  description = "Type of the boot disk for DB VM"
  default     = "network-hdd"
}

variable "vm_db_preemptible" {
  type        = bool
  description = "Whether the DB instance is preemptible"
  default     = true
}

variable "vm_db_nat" {
  type        = bool
  description = "Enable NAT for public IP for DB VM"
  default     = true
}


# variable "vm_db_cores" { type = number; default = 2 }
# variable "vm_db_memory" { type = number; default = 2 }
# variable "vm_db_core_fraction" { type = number; default = 20 }
# variable "vm_db_serial_port_enable" { type = number; default = 1 }