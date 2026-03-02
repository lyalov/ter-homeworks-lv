



ОТВЕТ 4 
Исправь блокирующую ошибку в providers.tf :
service_account_key_file = file("~/.authorized_key.json") 

Terraform не расширяет тильду ~ до домашнего каталога пользователя. Для функции file() путь ~/.authorized_key.json — это буквально файл с именем ~ в текущей директории, а не в домашней

как исправить 
service_account_key_file = file(pathexpand("~/.authorized_key.json"))  #
Функция pathexpand() явно раскрывает ~ в полный путь (например, /home/lyalov/).


Ошибка 2: Переменные объявлены в .tfvars, но не в variables.tf
Где: terraform.tfvars vs variables.tf
Суть ошибки:
В файле terraform.tfvars указаны значения для переменных token и vms_ssh_public_root_key, но в файле variables.tf отсутствуют блоки variable с такими именами. Terraform не знает, что делать с этими значениями.
Как исправить:
 Добавить объявления в variables.tf:

variable "token" {
  type        = string
  description = "OAuth/IAM токен Yandex Cloud"
  sensitive   = true
}

variable "vms_ssh_public_root_key" {
  type        = string
  description = "Публичный SSH-ключ для ВМ"
}


Проблема: В файле main.tf 

Исправление
platform_id = "standard-v4"   -- это ошибка V1 нужно выбрать 

resource "yandex_compute_instance" "platform" {
  name        = "netology-develop-platform-web"
  platform_id = "standart-v4"
  resources {
    cores         = 1 --это ошибка  нужно 2 это минимальное значени 
    memory        = 1
    core_fraction = 5  

    D:\gitlab\ter-homeworks-lv\02\images\ssh_ifconfig_me.png
    ssh_ifconfig_me.png

    ter-homeworks-lv\02\images\ssh_ifconfig_me.png
    ter-homeworks-lv\02\images\web_ip.png

Ответ 6

resources {
  cores         = 1
  memory        = 1
  core_fraction = 5      # ← минимальная гарантия CPU
}
scheduling_policy {
  preemptible = true     # ← прерываемая ВМ
}

Параметры preemptible = true и core_fraction=5 позволяют создавать максимально дешёвые виртуальные машины, достаточные для выполнения учебных задач: развёртывания инфраструктуры через Terraform, тестирования конфигураций, изучения Linux и сетевых настроек. Это снижает финансовый порог входа в обучение и позволяет безопасно экспериментировать с созданием и удалением ресурсов без риска значительных затрат.

Задание 2
 Ответ 2
  ter-homeworks-lv\02\images\no_change.png


Задание 3 + 4 
  Ответы 3+4

  lyalov@RedFox:/mnt/d/gitlab/ter-homeworks-lv/02/src$ terraform output
vms_info = {
  "db" = {
    "external_ip" = "130.193.51.240"
    "fqdn" = "fhmbcooghkcauie6ifb5.auto.internal"
    "instance_name" = "netology-develop-platform-db"
    "zone" = "ru-central1-a"
  }
  "web" = {
    "external_ip" = "51.250.67.139"
    "fqdn" = "fhml6i4hfnrsdb6ihlss.auto.internal"
    "instance_name" = "netology-develop-platform-web"
    "zone" = "ru-central1-a"
  }
}
   
   