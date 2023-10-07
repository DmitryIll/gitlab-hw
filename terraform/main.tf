

variable vpc_cidr_block {}
variable avail_zone {}
variable env_prefix {}
variable instance_ip {}
variable ipaddr_blocks {}
variable hostname_blocks {}

data "yandex_compute_image" "ubuntu-2004" {
  family = "ubuntu-2004-lts"
#  os_type = "linux"
}

resource "yandex_compute_instance" "jenkins" {
  name = "${var.env_prefix[0]}-server-1"
  platform_id = "standard-v2"
  zone = "ru-central1-b"
  hostname = var.hostname_blocks[0]

  resources {
    cores = 4
    memory = 6
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd80iv4u4kfmtosnuhtt"   #< image id from marketplace
    #  image_id = data.yandex_compute_image.ubuntu-2004.id
      size = 25
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.jenkins-sub.id
    nat = true
  }
  metadata = {
    serial-port-enable = 1
    user-data = "${file("meta.txt")}"
  }
  provisioner "file" {
    source = "~/netology-jenkins/jenkins_execute.sh"
    destination = "/home/jenadmin/jenkins_execute.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/jenkins_execute.sh",
          "cd ~",
          "~/jenkins_execute.sh"
    ]
  }
    connection {
      type = "ssh"
      user = "jenadmin" #var.user...
      private_key = file("~/netology-jenkins/key")  #< you need to generate new ssh key, like ssh-keygen
      host = self.network_interface[0].nat_ip_address
    }
  }

  # ----------------------------NGINX------------------------------------------
resource "yandex_compute_instance" "nginx" {
  name = "${var.env_prefix[2]}-server-1"
  platform_id = "standard-v2"
  zone = "ru-central1-b"
  hostname = var.hostname_blocks[2]

  resources {
    cores = 4
    memory = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004.id
      size = 25
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.jenkins-sub.id
    nat = true
  }
  metadata = {
    serial-port-enable = 1
    user-data = "${file("meta.txt")}"
  }
  provisioner "file" {
    source = "~/netology-jenkins/nginx_execute.sh"
    destination = "/home/jenadmin/nginx_execute.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/nginx_execute.sh",
          "cd ~",
          "~/nginx_execute.sh"
    ]
  }
    connection {
      type = "ssh"
      user = "jenadmin" #var.user...
      private_key = file("~/netology-jenkins/key")
      host = self.network_interface[0].nat_ip_address
    }
  }


# ----------------------------NEXUS------------------------------------------

resource "yandex_compute_instance" "nexus" {
  name = "${var.env_prefix[1]}-server-1"
  platform_id = "standard-v2"
  zone = "ru-central1-b"
  hostname = var.hostname_blocks[1]

  resources {
    cores = 4
    memory = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004.id
      size = 25
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.jenkins-sub.id
    nat = true
  }
  metadata = {
    serial-port-enable = 1
    user-data = "${file("meta.txt")}"
  }
  provisioner "file" {
    source = "~/netology-jenkins/nexus_execute.sh"
    destination = "/home/jenadmin/nexus_execute.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/nexus_execute.sh",
          "cd ~",
          "~/nexus_execute.sh"
    ]
  }
    connection {
      type = "ssh"
      user = "jenadmin" #var.user...
      private_key = file("~/netology-jenkins/key")
      host = self.network_interface[0].nat_ip_address
    }
  }




output "external_ip" {
  description = "The external IP address of the instance"
  value       = yandex_compute_instance.jenkins.*.network_interface.0.nat_ip_address
}
output "external_ip1" {
  description = "The external IP address of the instance"
  value       = yandex_compute_instance.nexus.*.network_interface.0.nat_ip_address
}
output "external_ip2" {
  description = "The external IP address of the instance"
  value       = yandex_compute_instance.nginx.*.network_interface.0.nat_ip_address
}

