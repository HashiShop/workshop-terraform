resource "aws_security_group" "hextris" {
    name = "hextris"
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
        Name = "hextris"
        Environment = "${terraform.env}"
        Application = "${var.app_name}"
    }
}
