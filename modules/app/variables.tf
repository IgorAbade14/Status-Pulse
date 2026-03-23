# ======================================================
# APP MODULE INPUTS
# ======================================================

variable "environment" {
  type = string
}

variable "instance_config" {
  type = map(string)
}

variable "ami_ubuntu" {
  type = string
}

variable "app_storage_bucket" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}