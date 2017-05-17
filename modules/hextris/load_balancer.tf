resource "aws_elb" "hextris" {
    name = "hextris-${terraform.env}"
    availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
    security_groups = ["${aws_security_group.hextris.id}"]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:80/"
        interval = 30
    }

    tags {
        Name = "hextris web app"
        Environment = "${terraform.env}"
        Application = "${var.app_name}"
    }
}
