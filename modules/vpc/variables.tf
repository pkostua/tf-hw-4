variable "env_name" {
  type = string
  description = "На основе этой строки будет сгеренировано имя сети и подсети"
}


variable "subnets" {
  type = list(object({
    zone: string,
    cidr: string
  }))
  description = "list of subnet params"
}

