# Sage Bionetworks AWS Service Catalog IAM Roles and Groups

The roles in this section support the launching of ServiceCatalog Products as launch constraints.
You can create them all at once or individually depending on the portfolio you are deploying.
The [ServiceCatalogEndusers](https://github.com/Sage-Bionetworks/scipoolprod-sc-lib-infra/blob/master/iam/sc-enduser-iam.yaml) Policy and group is used by all portfolios and should be created before any Portfolios.
Then, create the other roles as needed:
* [SCEC2LaunchRole](https://github.com/Sage-Bionetworks/scipoolprod-sc-lib-infra/blob/master/iam/sc-ec2vpc-launchrole.yaml) if you want to launch EC2 products
* [SCS3LaunchRole](https://github.com/Sage-Bionetworks/scipoolprod-sc-lib-infra/blob/master/iam/sc-s3-launchrole.yaml) if you want to launch S3 products

See the
 [ServiceCatalog IAM Guide](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/getstarted-iamenduser.html) for more details.
 Users, groups, and roles which will be provisioning Service Catalog products must have the
 **AWSServiceCatalogEndUserFullAccess** managed policy attached. If you have other roles which you want to give access to a portfolio, then use _LinkedRole1_ and _LinkedRole2_. If you wish to add other users or groups directly, then modify the portfolio templates with the
 [PortfolioPrincipalAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-portfolioprincipalassociation.html) resource.
