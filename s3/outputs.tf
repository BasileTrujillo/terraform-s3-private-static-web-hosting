output "bucket_id" {
  value = "${aws_s3_bucket.website_bucket.id}"
}

output "website_domain" {
  value = "${aws_s3_bucket.website_bucket.website_domain}"
}
output "hosted_zone_id" {
  value = "${aws_s3_bucket.website_bucket.hosted_zone_id}"
}