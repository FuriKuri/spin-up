variable "do_token" {}
variable "domain_name" {}
variable "ssh_fingerprint" {}

resource "digitalocean_droplet" "coreos" {
  count = "${var.service_count}"
  name = "${format("coreos-%02d", count.index)}"
  size = "512mb"
  image = "coreos-stable"
  region = "fra1"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  user_data = "${file(".build/service.yml")}"
}