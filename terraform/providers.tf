terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

 provider "yandex" {
   token     = "your token"           #<your token, to get it via yc iam create
   cloud_id  = "b1geg2"               #<your cloud
   folder_id = "b1g0m61n"             #< folder default
 }
