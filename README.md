# terraform-aws-cf-asg

A Terraform module for creating an Auto-Scaling Group using CloudFormation templates. Unfortunately Terraform does not provide an rolling update solution. One solution could be to create an entirely new ASG, update DNS records and destroy the old version. However, this can be cumbersome when this has to happen often. A rolling update replaces instances in the same ASG in pre-defined batches and does not require multiple deployments to update DNS and destory old

This module follows fairly closely with [tf_aws_asg](https://github.com/terraform-community-modules/tf_aws_asg) with the exception of manging everything via CloudFormation.

## Installation and usage

```hcl
module "asg" {
  source = "github.com/ImageIntelligence/terraform-aws-cf-asg"
  ...
}
```

## Variables

For input variables and their descriptions, please see the [variables.tf](./variables.tf) file. For output variables, see the [output.tf](./output.tf) file.
