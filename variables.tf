variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "eu-west-1"
}

variable "amis" {
    default = {
        "hextris" = "ami-627a7f04"
        "amzn_linux" = "ami-df99a4b9"
    }
}
