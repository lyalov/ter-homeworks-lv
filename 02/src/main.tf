
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}


resource "yandex_vpc_subnet" "develop_web" {
  name           = "${var.vpc_name}-web"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}


resource "yandex_vpc_subnet" "develop_db" {
  name           = "${var.vpc_name}-db"
  zone           = "ru-central1-b" 
  network_id     = yandex_vpc_network.develop.id 
  v4_cidr_blocks = ["10.0.2.0/24"]
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}


# VM Web

resource "yandex_compute_instance" "platform_web" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform_id
  zone        = "ru-central1-a"

  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vm_web_disk_type
    }
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_web.id  # ← Подсеть Web
    nat       = var.vm_web_nat
  }

  metadata = local.vm_metadata
}


# VM DB

resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform_id
  zone        = "ru-central1-b"  # ← ДРУГАЯ ЗОНА!

  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vm_db_disk_type
    }
  }

  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id  # ← Подсеть DB (ДРУГАЯ!)
    nat       = var.vm_db_nat
  }

  metadata = local.vm_metadata
}