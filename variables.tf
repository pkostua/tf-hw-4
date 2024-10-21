###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "image_family_ubuntu" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "default_environment" {
  type = string
  default = "develop"
}



#module vars
variable "projects" {
  type = list(string)
  default = ["marketing", "analytics"]
}
variable "default_owner_name" {
  type = string
  default = "k.p."
}


variable "default_vm_username" {
  type = string
  default = "ubuntu"
}




