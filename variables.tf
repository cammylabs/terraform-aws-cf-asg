/* launch config variables */

variable "lc-name-prefix" {
  description = "Creates a unique name beginning with this prefix"
}
variable "ami-id" {}
variable "instance-type" {}
variable "security-groups" {
  type = "list"
  description = "An array of security sg ids"
}
variable "iam-instance-profile" {
  description = "The ARN of the Instance Profile the LC should launch instances with"
}
variable "key-name" {
  description = "The name of a keypair"
}
variable "user-data" {
  description = "A string passed to the `user_data` field on EC2 boot"
}

/* associate a public ip address with an instance in a vpc */

variable "associate-public-ip-address" {
  default = true
}

/* asg config variables */

variable "asg-name" {}
variable "vpc-subnets" {}
variable "health-check-grace-period" {
  description = "Number of seconds to wait before checking the health status of instance"
}
variable "asg-min-instance-size" {}
variable "asg-max-instance-size" {}
variable "asg-desired-instance-count" {}
variable "min-instances-in-service" {
  description = "Minimum required EC2 boxes to be running during a rolling update"
}
variable "max-update-batch-size" {
  description = "Maximum number of boxes to update at a single time during a rolling update"
}

variable "timeout-in-minutes" {
  default = 30
  description = "The amount of time that can pass before the CF stack status becomes CREATE_FAILED"
}
variable "pause-time" {
  default = "PT0S"
  description = "The amount of time to pause after making a change to a batch of instances"
}
variable "environment" {
  default = "unknown"
  description = "A tag added to each EC2 instance in the ASG environment:unknown"
}
