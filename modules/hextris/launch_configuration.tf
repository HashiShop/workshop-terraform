resource "aws_launch_configuration" "hextris" {
    name = "hextris-${terraform.env}"

    image_id = "ami-627a7f04"
    instance_type = "t2.micro"

    security_groups = ["${aws_security_group.hextris.id}"]
}
