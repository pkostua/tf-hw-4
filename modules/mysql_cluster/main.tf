terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

resource "yandex_vpc_subnet" "cluster_subnets" {
  #Создаем одну подсеть для ha = false, a для true столько, сколько передали в переменной
  count = var.ha ? length(var.zones) : 1
  zone = var.zones[count.index].zone
  v4_cidr_blocks = [var.zones[count.index].cidr]
  network_id = var.network_id

}

resource "yandex_mdb_mysql_cluster" "this" {
  name      = var.cluster_name
  network_id = var.network_id
  environment = "PRESTABLE"
  version     =  var.cluster_version

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  dynamic "host" {
    for_each = range(var.ha?var.cluster_hosts_count : 1)
    content {
      #Подсеть хоста выбирается по порядку путем определния остатка от деления  номера текущего хоста на число подсетей
      zone = yandex_vpc_subnet.cluster_subnets[host.key % length(var.zones)].zone
      subnet_id = yandex_vpc_subnet.cluster_subnets[host.key % length(var.zones)].id
    }

  }
}