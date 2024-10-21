# Решение Домашнего задание к занятию «Продвинутые методы работы с Terraform
https://github.com/netology-code/ter-homeworks/blob/main/04/hw-04.md

## Задание 1
Скриншот подключения к консоли и вывод команды sudo nginx -t  
![image](https://github.com/user-attachments/assets/7cf51937-61a9-4cdf-ad74-f5d2971c5fa6)  
скриншот консоли ВМ yandex cloud  
![image](https://github.com/user-attachments/assets/707e04cf-4a9d-4dc6-9784-835eab8084ad)  
![image](https://github.com/user-attachments/assets/eb06a3e8-df11-4f24-8144-548cde07cd3f)    
Скриншот содержимого модуля  
![image](https://github.com/user-attachments/assets/714a7ce9-5c58-43e7-aa61-ef4eb7474a13)  
## Задание 2
### Скриншот информации о модуле
![image](https://github.com/user-attachments/assets/e520af71-8736-460e-a6b2-4323126b2a2f)  
Информация, сгенерированная terraform-docs находится в readme.md модуля

## Задание 3
### Список стейта
```
$ terraform state list
data.template_file.cloudinit
module.analytics-vm.data.yandex_compute_image.my_image
module.analytics-vm.yandex_compute_instance.vm[0]
module.marketing-vm.data.yandex_compute_image.my_image
module.marketing-vm.yandex_compute_instance.vm[0]
module.vpc_dev.yandex_vpc_network.network
module.vpc_dev.yandex_vpc_subnet.subnet
```
### Удаляем ресурсы
![image](https://github.com/user-attachments/assets/7c5c02ec-5a70-4066-a779-e4cddca1fbca)
### Возвращаем ресурсы.
Кончно же мы не сделаи бакап и не посмотрели terraform show. Сходим в консоль яндекса и перепишем идентификаторы
```
$ terraform import module.analytics-vm.yandex_compute_instance.vm[0] fhmn2cgrn9rmd0n21se8
$ terraform import module.marketing-vm.yandex_compute_instance.vm[0] fhmgdr7q5h8lb43i9913
$ terraform import module.vpc_dev.yandex_vpc_network.network enp3u75uaa7a5tbbujeq
$ terraform import module.vpc_dev.yandex_vpc_subnet.subnet e9bgtq87c1546s6ng2o8
```
### Проверяем план выполнения 
![image](https://github.com/user-attachments/assets/23b5a8a7-17ca-49a5-a51c-833beb525053)  
### Расследование
Во первых нужно понять откуда взялся этот параметр allow_stopping_for_update. Мы его не задавали, значит скорее всего модуль сделал эту работу. Так и есть, задается вот здесь https://github.com/udjin10/yandex_compute_instance/blob/main/main.tf
Но почему терраформ не импортировал этот параметр? Возможно провайдер-Яндекс по какойто причине не отдал информацию об этом параметре в терраформ? И тут вспоминаем первую лекцию: Терраформ же работает по АПИ!!!. Давайте найдем описание метода апи, кторый возвращает данные о ВМ.  
Нашлось описание метода вот здесь https://yandex.cloud/ru/docs/compute/api-ref/Instance/get. И ничего похожего на allow_stopping_for_update. Скорее всего АПИ яндекса не передает в терраформ это поле, отсюда и два изменения.


## Задание 4
### Код
Добавить ссылку
### План выполнения
Вот кусок плана, свзянного с сетями
```
 # module.vpc_dev.yandex_vpc_network.network will be created
  + resource "yandex_vpc_network" "network" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "develop"
      + subnet_ids                = (known after apply)
    }

  # module.vpc_dev.yandex_vpc_subnet.subnet["ru-central1-a"] will be created
  + resource "yandex_vpc_subnet" "subnet" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "develop-subnet-ru-central1-a"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.vpc_prod.yandex_vpc_network.network will be created
  + resource "yandex_vpc_network" "network" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "production"
      + subnet_ids                = (known after apply)
    }

  # module.vpc_prod.yandex_vpc_subnet.subnet["ru-central1-a"] will be created
  + resource "yandex_vpc_subnet" "subnet" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-subnet-ru-central1-a"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.vpc_prod.yandex_vpc_subnet.subnet["ru-central1-b"] will be created
  + resource "yandex_vpc_subnet" "subnet" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-subnet-ru-central1-b"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.2.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

  # module.vpc_prod.yandex_vpc_subnet.subnet["ru-central1-d"] will be created
  + resource "yandex_vpc_subnet" "subnet" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-subnet-ru-central1-d"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.3.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-d"
    }
```
### Скриншот из консоли
![image](https://github.com/user-attachments/assets/e61c9c6b-dbc9-4458-b8bb-b52e0f19695a)

## Задание 5
План выполнения при ha = false  
```
  # module.mysql_cluster.yandex_mdb_mysql_cluster.this will be created
  + resource "yandex_mdb_mysql_cluster" "this" {
      + allow_regeneration_host   = false
      + backup_retain_period_days = (known after apply)
      + created_at                = (known after apply)
      + deletion_protection       = (known after apply)
      + environment               = "PRESTABLE"
      + folder_id                 = (known after apply)
      + health                    = (known after apply)
      + host_group_ids            = (known after apply)
      + id                        = (known after apply)
      + mysql_config              = (known after apply)
      + name                      = "klaster"
      + network_id                = "enpahaaqqarh7ve1obkh"
      + status                    = (known after apply)
      + version                   = "8.0"

      + host {
          + assign_public_ip   = false
          + fqdn               = (known after apply)
          + replication_source = (known after apply)
          + subnet_id          = "e9brbbrb4fk7e8n5b4jq"
          + zone               = "ru-central1-a"
        }

      + resources {
          + disk_size          = 16
          + disk_type_id       = "network-ssd"
          + resource_preset_id = "s2.micro"
        }
    }

  # module.mysql_config.yandex_mdb_mysql_database.this will be created
  + resource "yandex_mdb_mysql_database" "this" {
      + cluster_id = (known after apply)
      + id         = (known after apply)
      + name       = "test"
    }

  # module.mysql_config.yandex_mdb_mysql_user.this will be created
  + resource "yandex_mdb_mysql_user" "this" {
      + authentication_plugin = (known after apply)
      + cluster_id            = (known after apply)
      + global_permissions    = (known after apply)
      + id                    = (known after apply)
      + name                  = "user"
      + password              = (sensitive value)

      + permission {
          + database_name = "test"
          + roles         = [
              + "ALL",
            ]
        }
    }
```
Получился клсатер  
![image](https://github.com/user-attachments/assets/e877f0c9-d1e2-4d68-9055-b2ba31d713a2)

Меняем ha = true
```
  # module.mysql_cluster.yandex_mdb_mysql_cluster.this will be updated in-place
  ~ resource "yandex_mdb_mysql_cluster" "this" {
        id                        = "c9qhu6sfq3poovpc6mp1"
        name                      = "klaster"
        # (15 unchanged attributes hidden)

      + host {
          + assign_public_ip = false
          + subnet_id        = (known after apply)
          + zone             = "ru-central1-b"
        }

        # (6 unchanged blocks hidden)
    }

  # module.mysql_cluster.yandex_vpc_subnet.cluster_subnets[1] will be created
  + resource "yandex_vpc_subnet" "cluster_subnets" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = (known after apply)
      + network_id     = "enpahaaqqarh7ve1obkh"
      + v4_cidr_blocks = [
          + "10.0.2.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }
```
