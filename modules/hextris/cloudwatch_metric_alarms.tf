resource "aws_cloudwatch_metric_alarm" "hextris_cpu_high" {
    alarm_name = "api-gateway-cpu-high-${terraform.env}"

    metric_name = "CPUUtilization"
    statistic = "Average"

    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = "80"

    period = "60"
    evaluation_periods = "2"

    namespace = "AWS/EC2"

    alarm_actions = ["${aws_autoscaling_policy.hextris_scale_in.arn}"]

    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.hextris.name}"
    }
}
resource "aws_cloudwatch_metric_alarm" "hextris_cpu_low" {
    alarm_name = "api-gateway-cpu-low-${terraform.env}"

    metric_name = "CPUUtilization"
    statistic = "Average"

    comparison_operator = "LessThanOrEqualToThreshold"
    threshold = "35"

    period = "60"
    evaluation_periods = "2"

    namespace = "AWS/EC2"

    alarm_actions = ["${aws_autoscaling_policy.hextris_scale_out.arn}"]

    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.hextris.name}"
    }
}
