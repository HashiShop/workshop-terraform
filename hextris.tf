# Security Groups
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

# Instances
resource "aws_instance" "hextris" {
    depends_on = ["aws_security_group.http_in"]

    ami = "${lookup(var.amis, "hextris")}"
    instance_type = "t2.micro"

    vpc_security_group_ids = ["${aws_security_group.http_in.id}"]

    tags {
        Name = "hextris web app"
        Environment = "${terraform.env}"
    }
}

# output
## url
output "hextris_url" {
    value = "${aws_instance.hextris.public_dns}"
}

## ip
output "hextris_ip" {
    value = "${aws_instance.hextris.public_ip}"
}
