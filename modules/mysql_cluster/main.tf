terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

resource "yandex_vpc_subnet" "cluster_subnets" {
  count = var.ha ? 2 : 1
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
    for_each = yandex_vpc_subnet.cluster_subnets
    content {
      zone = host.value.zone
      subnet_id = host.value.id
    }

  }
}