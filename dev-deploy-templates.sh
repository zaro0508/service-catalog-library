#!/bin/bash

# This script can be used while doing development
# List only the development files you're working on
# Those are uploaded to the S3 bucket where templates are stored
# Then, you sceptre to update the relevant development portfolio in scipoolprod-infra

set -ex

S3_BUCKET_URL=s3://bootstrap-awss3cloudformationbucket-19qromfd235z9/scipoolprod-sc-lib-infra/master/

# list the templates you're testing
templates=(
  ec2/development/sc-portfolio-ec2-development-tthyer.yaml
  ec2/development/sc-product-ec2-linux-jumpcloud-development-tthyer.yaml
  ec2/development/sc-ec2-linux-jumpcloud-development-tthyer.yaml
)

for template in "${templates[@]}"
do
  aws --profile admincentral-cfservice s3 cp $template $S3_BUCKET_URL$template
done
