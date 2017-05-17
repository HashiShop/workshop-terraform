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
        Application = "${var.app_name}"
    }
}
