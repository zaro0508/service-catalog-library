# Sage Bionetworks AWS Service Catalog Reference Architecture
This reference architecture is based on the original [aws-service-catalog-reference-architectures](https://github.com/aws-samples/aws-service-catalog-reference-architectures) from AWS, but has been heavily customized for Sage Bionetworks.

[AWS Service Catalog](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/introduction.html)
allows you to centrally manage commonly deployed AWS services, and helps you achieve consistent
governance which meets your compliance requirements, while enabling users to quickly deploy only
the approved AWS services they need.

This guide will help you deploy and manage your AWS ServiceCatalog using Infrastructure as Code (IaC).
 Read the [documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-reference-servicecatalog.html) for more information on ServiceCatalog and CloudFormation.

## Deployment
Merges to master will copy these templates to an S3 bucket that is used by [organizations-infra/sceptre/scipool](https://github.com/Sage-Bionetworks-IT/organizations-infra/tree/master/sceptre/scipool) to deploy stacks.

## Development
Currently there is a manual process for development. The steps are:
1. Deploy a test service catalog product template to an S3 bucket that has public access.
2. Reference that template in a template that deploys a product. Examples can be found in the individual
   [Sceptre templates in org-formation-infra repo](https://github.com/Sage-Bionetworks-IT/organizations-infra/tree/master/sceptre/scipool/config/develop)

Example:
```yaml
template:
  path: "sc-product-ec2-linux-docker.j2"
stack_name: "my-sc-product-ec2-linux-docker"
parameters:
  ProductName: "EC2: Linux Docker"
sceptre_user_data:
  # force cloudformation to update stack by setting a random number to the latest product's description
  ProvisioningArtifactParameters: |
    - Description: 'Test EC2 docker'
      Info:
        LoadTemplateFromURL: 'https://<TEST BUCKET>.s3.amazonaws.com/templates/ec2/sc-ec2-linux-docker.yaml'
      Name: 'v9.9.9'
```

### Account and Credentials
While the templates in this library could be used in any AWS account, Sage Bionetworks is currently deploying to the "scipooldev" and "scipoolprod" account.

## License
This project is licensed under the Apache 2.0 license - see the [LICENSE](LICENSE) file for details.
