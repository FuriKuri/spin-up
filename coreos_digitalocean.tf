variable "do_token" {}
variable "domain_name" {
	default = "furikuri.net"
}
variable "ssh_fingerprint" {}
variable "names" {
	default = "theo,furi"
}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "coreos" {
  count = "${length(split(",", var.names))}"
  name = "${format("coreos-%s", element(split(",", var.names), count.index))}"
  size = "512mb"
  image = "coreos-alpha"
  region = "fra1"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  user_data = "${file("cloud-config.yml")}"
}

resource "digitalocean_record" "coreos" {
    count = "${length(split(",", var.names))}"
    domain = "${var.domain_name}"
    type = "A"
    name = "${format("coreos-%s", element(split(",", var.names), count.index))}"
    value = "${element(digitalocean_droplet.coreos.*.ipv4_address, count.index)}"
}

output "fqdn" {
	value = "${join(",\n", digitalocean_record.coreos.*.fqdn)}"
}