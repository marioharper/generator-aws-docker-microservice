variable "env" {
  default = "dev"
}

variable "aws_region" {}

variable "project_name" {
  default = "<%= title %>"
}

variable "aws_account_id" {}

module "elastic-beanstalk" {
  source         = "../modules/elastic-beanstalk"
  env            = "${var.env}"
  aws_region     = "${var.aws_region}"
  project_name   = "${var.project_name}"
  aws_account_id = "${var.aws_account_id}"
}

output "app_cname" {
  value = "${module.elastic-beanstalk.app_cname}"
}

output "app_code" {
  value = "${module.elastic-beanstalk.app_code}"
}
