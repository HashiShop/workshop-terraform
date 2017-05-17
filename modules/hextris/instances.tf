resource "aws_instance" "hextris" {
    depends_on = ["aws_security_group.http_in"]

    ami = "ami-627a7f04"
    instance_type = "t2.micro"

    vpc_security_group_ids = ["${aws_security_group.http_in.id}"]

    tags {
        Name = "hextris web app"
        Environment = "${terraform.env}"
        Application = "${var.app_name}"
    }
}
