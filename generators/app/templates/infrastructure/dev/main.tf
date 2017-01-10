variable "env" {
  default = "dev"
}

module "elastic-beanstalk" {
  source = "../modules/elastic-beanstalk"
  env    = "${var.env}"
}

output "app_cname" {
  value = "${module.elastic-beanstalk.app_cname}"
}
