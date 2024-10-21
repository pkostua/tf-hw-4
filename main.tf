/*module "vpc_prod" {
  source       = "./modules/vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./modules/vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}

module "marketing-vm" {
  #пути к модулям невозможно поместить в переменную
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.default_environment
  network_id     = module.vpc_dev.subnet_info[0].net_id
  subnet_zones   = [module.vpc_dev.subnet_info[0].zone]
  subnet_ids     = [module.vpc_dev.subnet_info[0].subnet_id]
  instance_name  = "${var.projects[0]}vm"
  instance_count = 1
  image_family   = var.image_family_ubuntu
  public_ip      = true

  labels = {
    owner= var.default_owner_name,
    project = var.projects[0]
  }

  metadata = {
    user-data         = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

module "analytics-vm" {
  #пути к модулям невозможно поместить в переменную
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.default_environment
  network_id     = module.vpc_dev.subnet_info[0].net_id
  subnet_zones   = [module.vpc_dev.subnet_info[0].zone]
  subnet_ids     = [module.vpc_dev.subnet_info[0].subnet_id]
  instance_name  = "${var.projects[1]}vm"
  instance_count = 1
  image_family   = var.image_family_ubuntu
  public_ip      = true

  labels = {
    owner= var.default_owner_name,
    project = var.projects[1]
  }

  metadata = {
    user-data         = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}


#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    username           = var.default_vm_username
    ssh_public_key     = local.ssh_key
  }
}*/