##################################################
## Variables
##################################################
variable "aws_region" {
  type    = "string"
  default = "eu-west-1"
}

variable "full_domain" {
  type = "string"
}

variable "website_domain" {
  type = "string"
}

variable "hosted_zone_id" {
  type = "string"
}

variable "route53_zone_id" {
  type = "string"
}
