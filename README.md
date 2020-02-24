# Terraform for 2-tier architecture
This terraform code will generate two instances, one instance will contain the app and the other will contain the database. Theses instances will be generated in AWS in the region eu-west-1, using AMI's (one which already has the app and dependencies installed onto it and the other has the database dependencies). It will create a VPC, internet gateway, route table (with association), subnets and security groups.

## Terraform
Terraform is an orchestration tool, which will deploy AMI's into the cloud. It can use many providers and use different types of images and or provisioning. Terraform is used to write infrastructure as code.

## Start up the instances
To initialise terraform so that all the modules are accounted for, when in the terraform_2tier directory, in the command line type:
```
terraform init
```
To see what resources terraform will add, change or destroy, in the command line type:
```
terraform plan
```
To start building the architecture, in the command line type:
```
terraform apply
```

## How to use the app
For information on how to use the app: https://github.com/dilanmorar/node-sample-app
