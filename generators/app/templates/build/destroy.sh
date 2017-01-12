#!/bin/bash
set -e 

BASEDIR=$(dirname "$0")
BASEDIR=$PWD/$BASEDIR

cd $BASEDIR/infrastructure/dev

terraform remote config \
  -backend=s3 \
  -backend-config="bucket=volusion-terraform-state-dev" \
  -backend-config="key=<%= title %>/terraform.tfstate" 

terraform destroy --force
