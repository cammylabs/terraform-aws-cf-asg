# tf_aws_cf_asg

A Terraform module for creating an Auto-Scaling Group using CloudFormation templates. This is necessary as Terraform doesn't give you rolling updates for free.

This module follows fairly closely with [tf_aws_asg](https://github.com/terraform-community-modules/tf_aws_asg) with the exception of manging everything via CloudFormation.

## Input Variables

* `lc-name-prefix` - Creates a unique name beginning with the specified prefix.
* `ami-id`
* `instance-type`
* `security-groups` - An array of security (sg) ids.
* `iam-instance-profile` - The ARN of the Instance Profile the LC should launch instances with.
* `key-name` - The name of a keypair.
* `user-data` - A string passed to the `user_data` field on EC2 boot.
* `asg-name`
* `vpc-subnets`
* `health-check-grace-period` - Number of seconds for the health check time out.
* `asg-min-instance-size` - Minimum number of EC2 boxes in our ASG.
* `asg-max-instance-size` - Maximum number of EC2 boxes in our ASG.
* `asg-desired-instance-count` - Desired number of running EC2 boxes in our ASG.
* `min-instances-in-service` - Minimum required EC2 boxes to be running during a rolling update.
* `max-update-batch-size`- Maximum number of boxes to update at a single time during a rolling update.
* `environment` (optional) - An environment tag (default: Unknown)

## Output Variables

* `asg-name`
* `launch-config-id`

## Usage

```hcl
module "asg" {
    source = "github.com/imageintelligence/tf_aws_cf_asg"
    ...
}
```
