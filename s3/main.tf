##################################################
## AWS config
##################################################
provider "aws" {
  region = "${var.aws_region}"
}

################################################################################################################
## Configure the bucket and static website hosting
################################################################################################################
data "template_file" "bucket_policy" {
  template = "${file("${path.module}/s3_ip_restrict_policy.json")}"

  vars {
    bucket = "${var.full_domain}"
    allowed_ip = "${var.allowed_ip}"
  }
}

resource "aws_s3_bucket" "website_bucket" {
  bucket  = "${var.full_domain}"
  acl     = "public-read"
  policy   = "${data.template_file.bucket_policy.rendered}"

  website {
    index_document = "${var.index_document}"
    error_document = "${var.error_document}"
    routing_rules  = "${var.routing_rules}"
  }

  //  logging {
  //    target_bucket = "${var.log_bucket}"
  //    target_prefix = "${var.log_bucket_prefix}"
  //  }

  tags = "${merge("${var.tags}",map("Name", "${var.full_domain}"))}"
}

################################################################################################################
## Configure the credentials and access to the bucket for a deployment user
################################################################################################################
data "template_file" "deployer_role_policy_file" {
  template = "${file("${path.module}/deployer_role_policy.json")}"

  vars {
    bucket = "${var.full_domain}"
  }
}

resource "aws_iam_policy" "site_deployer_policy" {
  name        = "${var.full_domain}.deployer"
  path        = "/"
  description = "Policy allowing to publish a new version of the website to the S3 bucket"
  policy      = "${data.template_file.deployer_role_policy_file.rendered}"
}

resource "aws_iam_policy_attachment" "site-deployer-attach-user-policy" {
  name       = "${var.full_domain}-deployer-policy-attachment"
  users      = ["${var.deployer}"]
  policy_arn = "${aws_iam_policy.site_deployer_policy.arn}"
}
