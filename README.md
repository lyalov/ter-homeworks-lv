Домащнее задания  «Введение в Terraform» 
Ялова Л. В

Вопрос 1.2
Изучите файл .gitignore. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?(логины,пароли,ключи,токены итд)

Ответ 1.2  в файле  .gitignore указан  personal.auto.tfvars будут содержаться логины пароли ключи, но по факту создался файл 

Вопрос 1.3
Выполните код проекта. Найдите в state-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.

Ответ 1.3
{
  "version": 4,
  "terraform_version": "1.14.5",
  "serial": 1,
  "lineage": "53642c3e-2d47-0dd3-b8a6-3f4a6ebbef68",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "random_password",
      "name": "random_string",
      "provider": "provider[\"registry.terraform.io/hashicorp/random\"]",
      "instances": [
        {
          "schema_version": 3,
          "attributes": {
            "bcrypt_hash": "$2a$10$9165vjRZV7T8pgC7EQMPsO/vdL6VL.ZpJ/z4tbhr7x2PbAGXifsXy",
            "id": "none",
            "keepers": null,
            "length": 16,
            "lower": true,
            "min_lower": 1,
            "min_numeric": 1,
            "min_special": 0,
            "min_upper": 1,
            "number": true,
            "numeric": true,
            "override_special": null,
            "result": "8rCdwKPrO55j3MvH",
            "special": false,
            "upper": true
          },
          "sensitive_attributes": [
            [
              {
                "type": "get_attr",
                "value": "bcrypt_hash"
              }
            ],
            [
              {
                "type": "get_attr",
                "value": "result"
              }
            ]
          ],
          "identity_schema_version": 0
        }
      ]
    }
  ],
  "check_results": null
}

Вопрос 1.4
Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.

Ответ 1.4
В данном вопросе преднамеренные ошибки:

Ошибка 1: Нет имени ресурса!

resource "docker_image" {          
  name         = "nginx:latest"
  keep_locally = true
}

Ошибка 2: Имя не может начинаться с цифры

resource "docker_container" "1nginx" {   
Ошибка 3: Ссылка на несуществующий ресурс "nginx"

  image = docker_image.nginx.image_id         
  name  = "example_${random_password.random_string_FAKE.resulT}"  --  Ошибка 4 + 5: Неверное имя ресурса + опечатка в атрибуте

  ports {
    internal = 80
    external = 9090
  }
}


Ответ 1.5
исправленный фрагмент:

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}


ОТВЕТ 1.6
#####            После запуска кода         ######

lyalov@RedFox:/mnt/d/gitlab/ter-homeworks-lv/01/src$ terraform apply
random_password.random_string: Refreshing state... [id=none]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = (known after apply)
      + init                                        = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = (sensitive value)
      + network_data                                = (known after apply)
      + network_mode                                = "bridge"
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck (known after apply)

      + labels (known after apply)

      + ports {
          + external = 9090
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id           = (known after apply)
      + image_id     = (known after apply)
      + keep_locally = true
      + name         = "nginx:latest"
      + repo_digest  = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_image.nginx: Creating...
docker_image.nginx: Creation complete after 0s [id=sha256:c881927c4077710ac4b1da63b83aa163937fb47457950c267d92f7e4dedf4aecnginx:latest]
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 1s [id=9978376ae3db8fc3d39bc4a89cf7adcc1224557d4473fa56226f340d449dc10e]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
lyalov@RedFox:/mnt/d/gitlab/ter-homeworks-lv/01/src$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
9978376ae3db   c881927c4077   "/docker-entrypoint.…"   12 seconds ago   Up 11 seconds   0.0.0.0:9090->80/tcp   example_8rCdwKPrO55j3MvH

Применяем terraform apply -auto-approv

lyalov@RedFox:/mnt/d/gitlab/ter-homeworks-lv/01/src$ docker ps 
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
69b18581672b   c881927c4077   "/docker-entrypoint.…"   51 seconds ago   Up 50 seconds   0.0.0.0:9090->80/tcp   hello_worl

Имя поменялость но есть одно но!

Ключ -auto-approve отключает интерактивное подтверждение перед применением изменений. Terraform сразу выполняет все изменения без вопроса вида "Do you want to perform these actions?"
ОПАСТНО!   Если в коде есть ошибка или  находимся  не в той директории, Terraform может случайно уничтожить или изменить критические ресурсы без возможности отмены. 

ОТВЕТ 1.7
Содержимое файла 
{
  "version": 4,
  "terraform_version": "1.14.5",
  "serial": 12,
  "lineage": "53642c3e-2d47-0dd3-b8a6-3f4a6ebbef68",
  "outputs": {},
  "resources": [],
  "check_results": null
}


ОТВЕТ 1.8
контейнер не удалилися потому что в файле main.tf есть строка 
keep_locally = true
которая является флагом для тераформа 
https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image

keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.
