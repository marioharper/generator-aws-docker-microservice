#!/bin/bash
set -e 

BASEDIR=$(dirname "$0")
BASEDIR=$PWD/$BASEDIR
export TF_VAR_aws_account_id=$(aws sts get-caller-identity --output text --query 'Account')
export TF_VAR_aws_region=$AWS_DEFAULT_REGION

cd $BASEDIR/../infrastructure/dev

terraform remote config \
  -backend=s3 \
  -backend-config="bucket=volusion-terraform-state-dev" \
  -backend-config="key=<%= title %>/terraform.tfstate" 

terraform get
terraform plan
terraform apply

# create app version // terraform should support this soon
aws elasticbeanstalk create-application-version \
  --application-name "<%= title %>" \
  --version-label v1 \
  --source-bundle S3Bucket=$(terraform output app_code_s3_bucket),S3Key=$(terraform output app_code_s3_key) \
  --no-auto-create-application

# deploy app version 
aws elasticbeanstalk update-environment \
  --application-name "<%= title %>" \
  --environment-name "Default-Environment" \
  --version-label v1