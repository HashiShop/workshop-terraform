## url
output "hextris_url" {
    value = "${aws_instance.hextris.public_dns}"
}

## ip
output "hextris_ip" {
    value = "${aws_instance.hextris.public_ip}"
}
