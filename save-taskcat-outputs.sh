#!/bin/bash
set -e

# Upload taskcat test output to S3 bucket
REPO_NAME="${PWD##*/}"
S3_BUCKET=$(aws cloudformation list-exports --query "Exports[?Name=='us-east-1-taskcat-TastcatSynapseBucket'].Value" --output text)
S3_BUCKET_PATH="$REPO_NAME/$TRAVIS_BUILD_NUMBER"
S3_BUCKET_URL="s3://$S3_BUCKET/$S3_BUCKET_PATH"
SOURCE_DIR=taskcat_outputs
aws s3 cp --recursive ${SOURCE_DIR} $S3_BUCKET_URL/
