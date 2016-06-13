variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  default = "eu-central-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = 2

  ami                    = "ami-74ee001b"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-99a58be2"
  vpc_security_group_ids = ["sg-8e08dfe6"]

  tags {
    Identity = "hashiconf-c81e728d9d4c2f636f067f89cc14862c"
    Owner    = "Erran Carey (e)"
  }
}

output "owner_blob" {
  value = "${aws_instance.web.0.tags.Owner} owns the instance ${aws_instance.web.0.id}."
}

output "public_dns" {
  value = "${join(", ", aws_instance.web.*.public_dns)}"
}

output "public_ip" {
  value = "${join(", ", aws_instance.web.*.public_ip)}"
}
