##################################################
## Variables
##################################################
variable "aws_region" {
  type    = "string"
  default = "eu-west-1"
}

variable "full_domain" {
  type = "string"
  default = "my-website.example.io"
}

##################################################
## AWS config
##################################################
provider "aws" {
  region = "${var.aws_region}"
}

##################################################
## S3 Bucket
##################################################
module "s3_private_website" {
  source = "github.com/BasileTrujillo/terraform-s3-private-static-web-hosting//s3"
  aws_region = "${var.aws_region}"

  deployer = "my_user"
  allowed_ip = "XX.XXX.XXX.XX"

  full_domain = "${var.full_domain}"
  index_document = "index.html"
  error_document = "404.html"
}

##################################################
## Route 53 Alias
##################################################
module "dns-alias" {
  source = "github.com/BasileTrujillo/terraform-s3-private-static-web-hosting//route53-alias"
  aws_region = "${var.aws_region}"

  full_domain = "${var.full_domain}"
  route53_zone_id = "XXXXXXXXXXXXXX"
  website_domain = "${module.s3_private_website.website_domain}"
  hosted_zone_id = "${module.s3_private_website.hosted_zone_id}"
}

##################################################
## Output used for file deployment
##################################################
output "bucket_id" {
  value = "${module.s3_private_website.bucket_id}"
}