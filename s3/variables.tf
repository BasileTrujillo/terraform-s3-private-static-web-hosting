##################################################
## Variables
##################################################
variable "aws_region" {
  type    = "string"
  default = "eu-west-1"
}

variable "force_destroy" {
  type = "string"
  default = "false"
}

variable "full_domain" {
  type = "string"
}

variable "allowed_ip" {
  type = "string"
}

variable routing_rules {
  type = "string"
  default = ""
}

variable index_document {
  type = "string"
  default = "index.html"
}

variable error_document {
  type = "string"
  default = "404.html"
}

variable "tags" {
  type        = "map"
  description = "Optional Tags"
  default     = {}
}


//variable log_bucket {
//  type = "string"
//}
//variable log_bucket_prefix {
//  type = "string"
//}