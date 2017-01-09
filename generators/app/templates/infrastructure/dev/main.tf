variable "env" {
  default = "dev"
}

module "elastic-beanstalk" {
  source = "../modules/elastic-beanstalk"
  env = "${var.env}"
}

output "api_cname" {
  value = "${module.elastic-beanstalk.api_cname}"
}