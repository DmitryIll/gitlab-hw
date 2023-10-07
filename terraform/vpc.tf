resource "yandex_vpc_network" "jenkins-net" {
  name = "jenkins-net"
}

resource "yandex_vpc_subnet" "jenkins-sub" {
  name           = "jenkins-subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.jenkins-net.id
  v4_cidr_blocks = ["10.240.1.0/24"]
}
