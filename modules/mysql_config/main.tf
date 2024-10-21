terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}


resource "yandex_mdb_mysql_database" "this" {
  name       = var.database_name
  cluster_id = var.cluster_id
}

resource "yandex_mdb_mysql_user" "this" {
  name       = var.user_name
  cluster_id = var.cluster_id
  password   = random_password.password.result

  permission {
    database_name = var.database_name
    roles          = ["ALL"]
  }
}

resource "random_password" "password" {
  length  = 16
  special = true
}