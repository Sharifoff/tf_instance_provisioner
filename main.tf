variable "ami" {
  default = "ami-0b5eea76982371e91"
}

variable "instance_type" {
  default = "m5.large"
}

variable "region" {
  default = "us-east-1"
}

resource "aws_instance" "cerberus" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = "cerberus"
  user_data = file("./install-nginx.sh")
}

resource "aws_key_pair" "keyyy" {
  key_name = "keyyy"
  public_key = file(".ssh/id.pub")
}


resource "aws_eip" "eip" {
  vpc      = true
  instance = aws_instance.cerberus.id
  provisioner "local-exec" {
    command = "echo ${aws_eip.eip.public_dns} >> /home/cloudshell-user/cerberus_public_dns.txt"
  }

}
