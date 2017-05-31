# terraform-s3-private-static-web-hosting
Terraform script to setup an AWS S3 Bucket as IP restricted static web hosting.

## What this script does
* Create a new AWS S3 Bucket
* Setup it as static web hosting
* Restrict it to a specific IP
* Add deployment policy to specified user
* (optionnal) Add Route 53 Alias pointing to the bucket

## Usage
Create a main.tf file with the following configuration:

```hcl
module "s3_private_website" {
  source = "github.com/BasileTrujillo/terraform-s3-private-static-web-hosting//s3"
  aws_region = "eu-west-1"

  deployer = "MyUser"
  bucket_name = "my-website.example.io"
  allowed_ip = "XX.XXX.XXX.XXX"

  full_domain = "my-website.example.io"
  index_document = "index.html"
  error_document = "404.html"
}
```

To add Route 53 Alias, add the following module : 

```hcl
module "dns-alias" {
  source = "github.com/BasileTrujillo/terraform-s3-private-static-web-hosting//route53-alias"
  aws_region = "eu-west-1"

  full_domain = "my-website.example.io"
  route53_zone_id = "XXXXXXXXXXXX"
  website_domain = "${module.s3_private_website.website_domain}"
  hosted_zone_id = "${module.s3_private_website.hosted_zone_id}"
}
```

For a full example, take a look at `example/` directory.
This example also include a tiny script to deploy your site to the created S3 Bucket