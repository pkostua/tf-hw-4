variable "cluster_name" {
  description = "Имя кластера"
  type        = string
}

variable "network_id" {
  description = "ID сети"
  type        = string
}

variable "ha" {
  description = "Флаг для включения высокой доступности"
  type        = bool
  default     = false
}

variable "zones" {
  type        = list(object(
    {
      zone: string
      cidr: string
    }
  ))
  default     = [
    {
      zone = "ru-central1-a"
      cidr = "10.0.1.0/24"
    },
    {
      zone = "ru-central1-b"
      cidr = "10.0.2.0/24"
    }
  ]
}

variable "cluster_version" {
  type = string
  default = "8.0"
  description = "Version of the MySQL cluster."
}

variable "cluster_hosts_count" {
  type = number
  default = 2
  description = "Number of cluster hosts"
}
