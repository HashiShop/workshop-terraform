data "aws_route53_zone" "veber_cloud" {
    name = "veber.cloud."
}

resource "aws_route53_record" "hextris" {
    zone_id = "${data.aws_route53_zone.veber_cloud.zone_id}"
    name = "hextris"
    type = "A"

    alias {
        name = "${aws_elb.hextris.dns_name}"
        zone_id = "${aws_elb.hextris.zone_id}"
        evaluate_target_health = true
    }
}
