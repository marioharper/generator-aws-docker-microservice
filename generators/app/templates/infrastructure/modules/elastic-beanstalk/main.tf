variable "env" {}

resource "aws_elastic_beanstalk_application" "app" {
  name        = "<%= title %>"
  description = "tf-test-desc"
}

resource "aws_elastic_beanstalk_environment" "api" {
  name                = "<%= title %>"
  tier                = "WebServer"
  application         = "${aws_elastic_beanstalk_application.app.name}"
  solution_stack_name = "64bit Amazon Linux 2016.09 v2.3.0 running Docker 1.11.2"

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "ENV"
    value     = "${var.env}"
  }
}

output "api_cname" {
  value = "${aws_elastic_beanstalk_environment.api.cname}"
}
