# Sage Bionetworks AWS Service Catalog S3 Reference architecture

This reference architecture creates an AWS Service Catalog Portfolio called "Service Catalog S3 Reference Architecture" with two associated products. The AWS Service Catalog Product references cloudformation templates for the Amazon S3 buckets which can be lauched by end users through Service Catalog. The AWS Service Catalog S3 products create S3 buckets with varying configurations:
#S3 Private Encrypted Bucket
#S3 Synapse Bucket, also private and ecrypted, but with Synapse integration
