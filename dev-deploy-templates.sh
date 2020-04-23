#!/bin/bash

# This script can be used while doing development
# Requires either a file or directory as argument
# Those are uploaded to the S3 bucket where templates are stored
# Then run sceptre to update the relevant development portfolio in scipoolprod-infra

if [[ -d "$1" ]]; then
  DIR="$1"
  if [[ "${DIR}" != */ ]]; then
    DIR="${DIR}/"
  fi
  templates=("$DIR"*.yaml)
elif [[ -f "$1" ]]; then
  FILE="$1"
  templates=("$FILE")
else
  printf "A directory or file argument is required\n" >&2
  exit 1
fi 

S3_BUCKET_URL=s3://bootstrap-awss3cloudformationbucket-19qromfd235z9/scipoolprod-sc-lib-infra/master/

for template in "${templates[@]}"
do
  aws --profile admincentral-cfservice s3 cp $template $S3_BUCKET_URL$template
done
