

resource "yandex_vpc_network" "cluster_network" {
  name = var.mysql_cluster_name
}

module "mysql_cluster" {
  source      = "./modules/mysql_cluster"
  cluster_name = var.mysql_cluster_name
  network_id   = yandex_vpc_network.cluster_network.id
  ha           = true # Сначала создаем кластер с одним хостом
}

module "mysql_config" {
  source        = "./modules/mysql_config"
  database_name = "test"
  user_name     = "user"
  cluster_id    = module.mysql_cluster.cluster_id # ID созданного кластера
}