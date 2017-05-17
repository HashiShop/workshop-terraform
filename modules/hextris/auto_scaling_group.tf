resource "aws_autoscaling_group" "hextris" {
    name = "hextris-${terraform.env}"

    min_size = 2
    max_size = 4

    availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

    launch_configuration = "${aws_launch_configuration.hextris.name}"

    load_balancers = ["${aws_elb.hextris.name}"]

    tag {
        key = "Name"
        value = "hextris"
        propagate_at_launch = "true"
    }

    tag {
        key = "Environment"
        value = "${terraform.env}"
        propagate_at_launch = "true"
    }

    tag {
        key = "Application"
        value = "${var.app_name}"
        propagate_at_launch = "true"
    }
}

resource "aws_autoscaling_policy" "hextris_scale_in" {
    name = "hextris-scale-in-${terraform.env}"

    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = 1
    cooldown = 120

    autoscaling_group_name = "${aws_autoscaling_group.hextris.name}"
}

resource "aws_autoscaling_policy" "hextris_scale_out" {
    name = "hextris-scale-out-${terraform.env}"

    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = -1
    cooldown = 120

    autoscaling_group_name = "${aws_autoscaling_group.hextris.name}"
}
