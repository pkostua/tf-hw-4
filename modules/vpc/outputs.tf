output "subnet_info" {
  value = [for s in yandex_vpc_subnet.subnet: {
    subnet_id = s.id
    net_id = s.network_id
    zone = s.zone
  }]
  description = "Информация о созданной подсети"
}
