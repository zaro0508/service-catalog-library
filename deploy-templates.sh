#!/bin/bash
set -e

# Deploy templates to AWS Admincentral account to share with other projects.

# Clean existing files on S3 bucket
aws s3 rm --recursive $S3_BUCKET_URL/

# Upload dirs and files to S3 bucket
DIRS=$(ls -d */)
for dir in $DIRS
do
  aws s3 cp --recursive ${dir} $S3_BUCKET_URL/${dir}
done
