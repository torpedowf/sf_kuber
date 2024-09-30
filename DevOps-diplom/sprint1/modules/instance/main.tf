data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}


# Provider
provider "yandex" {
  token     = var.user_token
  cloud_id  = var.user_cloud
  folder_id = var.user_folder
  zone = "ru-central1-a"
}

# Service accounts
resource "yandex_iam_service_account" "sf-admin" {
  name = "sf-admin"
}

resource "yandex_resourcemanager_folder_iam_member"  "sf-admin-policy" {
   folder_id = var.user_folder
  role = "admin"
  member = "serviceAccount:${yandex_iam_service_account.sf-admin.id}"
    
  depends_on = [
    yandex_iam_service_account.sf-admin,
  ]
}

# Static Access Keys
resource "yandex_iam_service_account_static_access_key" "static-access-key" {
  service_account_id = yandex_iam_service_account.sf-admin.id
  depends_on = [
    yandex_iam_service_account.sf-admin,
  ]
}

# Compute instance for service
# Создаём ВМ - srv сервисную ноду, с которой будет просиходить развёртывание кластера k8s, мониторинг, логирование и процессы CI/CD
resource "yandex_compute_instance" "srv" { 
  name     = "srv"
  hostname = "srv"

  resources {
    cores  = 4
    memory = 12
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      size     = 30
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.ssh_credentials.user}:${file(var.ssh_credentials.pub_key)}"
    serial-port-enable=1
  }

}