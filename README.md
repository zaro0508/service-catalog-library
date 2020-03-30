# Sage Bionetworks AWS Service Catalog Reference Architecture
This reference architecture is based on the original [aws-service-catalog-reference-architectures](https://github.com/aws-samples/aws-service-catalog-reference-architectures) from AWS, but has been heavily customized for Sage Bionetworks.

[AWS Service Catalog](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/introduction.html) 
allows you to centrally manage commonly deployed AWS services, and helps you achieve consistent
governance which meets your compliance requirements, while enabling users to quickly deploy only
the approved AWS services they need. 

This guide will help you deploy and manage your AWS ServiceCatalog using Infrastructure as Code (IaC).
 Read the [documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-reference-servicecatalog.html) for more information on ServiceCatalog and CloudFormation.  

Sage Bionetworks uses a second repository, [scipoolprod-infra](https://github.com/Sage-Bionetworks/scipoolprod-infra), to deploy Cloudformation stacks defined by the templates in this library.

## Deployment
Merges to master will copy these templates to an S3 bucket that is used by [scipoolprod-infra](https://github.com/Sage-Bionetworks/scipoolprod-infra) to deploy stacks.

## Development
Currently there is a manual process for development. The script `dev-deploy-templates.sh`, when run from the project root, takes a file or directory path and copys the templates found there to the deployment bucket. These can then be referenced when creating deployment stacks in [scipoolprod-infra](https://github.com/Sage-Bionetworks/scipoolprod-infra).

### Example
```bash
# copies all files found at path ec2/development to the deployment bucket
./dev-deploy-templates.sh ec2/development
```

For example, this will create a file at `s3://bootstrap-awss3cloudformationbucket-19qromfd235z9/scipoolprod-sc-lib-infra/master/ec2/development/sc-ec2-linux-jumpcloud-development.yaml`

Switching to scipoolprod-infra to create a configuration to deploy the stack, create a yaml file in config/dev with contents that looks like the following, and note that in the hooks section the template path is copied to a local folder for use:
```
template_path: "remote/sc-portfolio-ec2-development.yaml"
stack_name: "sc-portfolio-ec2-development"
dependencies:
  - "prod/sc-ec2vpc-launchrole.yaml"
  - "prod/sc-enduser-development-iam.yaml"
parameters:
  LaunchRoleName: "SCEC2LaunchRole"
  RepoRootURL: "https://s3.amazonaws.com/{{stack_group_config.admincentral_cf_bucket}}/scipoolprod-sc-lib-infra/master/"
  PrincipalRoleName1: "ServiceCatalogDevelopmentEndusers"
  PrincipalGroupName1: "ServiceCatalogDevelopmentEndusers"
  StackDatetime: !date
hooks:
  before_create:
    - !cmd "curl https://s3.amazonaws.com/{{stack_group_config.admincentral_cf_bucket}}/scipoolprod-sc-lib-infra/master/ec2/development/sc-portfolio-ec2-development.yaml --create-dirs -o templates/remote/sc-portfolio-ec2-development.yaml"
  before_update:
    - !cmd "curl https://s3.amazonaws.com/{{stack_group_config.admincentral_cf_bucket}}/scipoolprod-sc-lib-infra/master/ec2/development/sc-portfolio-ec2-development.yaml --create-dirs -o templates/remote/sc-portfolio-ec2-development.yaml"
```

## License  
This project is licensed under the Apache 2.0 license - see the [LICENSE](LICENSE) file for details
