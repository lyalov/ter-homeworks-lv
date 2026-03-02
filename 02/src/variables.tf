variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Yandex Folder ID"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default zone for resources"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "Default CIDR for subnets"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network name"
}

variable "vms_ssh_root_key" {
  type        = string
  description = "SSH public key for VMs"
  default     = ""  
}

variable "token" {
  type        = string
  description = "Yandex Cloud IAM token (not used when using service_account_key_file)"
  sensitive   = true
  default     = ""  
}