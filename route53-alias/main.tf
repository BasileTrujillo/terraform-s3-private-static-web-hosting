##################################################
## AWS config
##################################################
provider "aws" {
  region = "${var.aws_region}"
}

################################################################################################################
## Create a Route53 ALIAS record to the S3 website hosting
################################################################################################################
resource "aws_route53_record" "cdn-alias" {
  zone_id = "${var.route53_zone_id}"
  name    = "${var.full_domain}"
  type    = "A"

  alias {
    name                   = "${var.website_domain}"
    zone_id                = "${var.hosted_zone_id}"
    evaluate_target_health = false
  }
}