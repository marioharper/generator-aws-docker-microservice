variable "env" {}

variable "aws_region" {}

variable "project_name" {}

variable "aws_account_id" {}

variable "app_code_path" {
  default = "../../"
}

variable "app_code_file" {
  default = "Dockerrun.aws.json"
}

resource "aws_elastic_beanstalk_application" "app" {
  name        = "<%= title %>"
  description = "tf-test-desc"
}

resource "aws_elastic_beanstalk_environment" "appEnv" {
  name                = "Default-Environment"
  tier                = "WebServer"
  application         = "${aws_elastic_beanstalk_application.app.name}"
  solution_stack_name = "64bit Amazon Linux 2016.09 v2.3.0 running Docker 1.11.2"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "aws-elasticbeanstalk-service-role"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.nano"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "ENV"
    value     = "${var.env}"
  }
}

resource "aws_s3_bucket_object" "application_code" {
  bucket = "elasticbeanstalk-${var.aws_region}-${var.aws_account_id}"
  key    = "${var.project_name}/${var.app_code_file}"
  source = "${var.app_code_path}${var.app_code_file}"
  etag   = "${md5(file("${var.app_code_path}${var.app_code_file}"))}"
}

output "app_cname" {
  value = "${aws_elastic_beanstalk_environment.appEnv.cname}"
}
