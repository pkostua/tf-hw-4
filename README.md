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
Во первых нужно понять откуда взялся этот параметр allow_stopping_for_update. Мы его не задавали, значит скорее всего модуль сделал эту работу. Так и есть, задается вот здесь https://github.com/udjin10/yandex_compute_instance/blob/main/main.tf
Но почему терраформ не импортировал этот параметр. Видимо провайдер-Яндекс по какойто причине не отдал информацию об этом папраметре в терраформ. И тут вспоминаем первую лекцию Терраформ же работает по АПИ!!!. Давайте найдем описание метода апи, кторый возвращает данные о ВМ.  
Нашлось описание метода вот здесь https://yandex.cloud/ru/docs/compute/api-ref/Instance/get. И ничего похожего на allow_stopping_for_update. Скорее всего АПИ яндекса не передает в терраформ это поле, отсюда и два изменения.


