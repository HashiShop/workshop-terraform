# Variables
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "eu-west-1"
}

# Providers
provider "aws" {
    access_key = "${var.AWS_ACCESS_KEY}"
    secret_key = "${var.AWS_SECRET_KEY}"
    region = "${var.AWS_REGION}"
}

# Resources
## Security Groups
resource "aws_security_group" "http_in" {
    name = "http in"
    description = "Allow http inbound traffic"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "http in"
        Environment = "${terraform.env}"
    }
}

## Instances
resource "aws_instance" "hextris" {
    ami = "ami-627a7f04"
    instance_type = "t2.micro"

    vpc_security_group_ids = ["${aws_security_group.http_in.id}"]

    tags {
        Name = "hextris web app"
        Environment = "${terraform.env}"
    }
}

# output
output "hextris_url" {
    value = "${aws_instance.hextris.public_dns}"
}
