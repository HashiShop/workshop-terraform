resource "aws_instance" "amzn_linux" {
    ami = "${lookup(var.amis, "amzn_linux")}"
    instance_type = "t2.micro"

    tags {
        Name = "amazon linux"
        Environment = "${terraform.env}"
    }
}
