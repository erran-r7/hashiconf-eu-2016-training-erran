variable "dnsimple_token" {}

provider "dnsimple" {
  email = "sethvargo+terraform@gmail.com"
  token = "${var.dnsimple_token}"
}

resource "dnsimple_record" "web" {
  domain = "terraform.rocks"
  name = "err7n"
  type = "A"
  value = "${aws_instance.web.0.public_ip}"
}

output "primary_hostname" {
  value = "${dnsimple_record.web.hostname}"
}
