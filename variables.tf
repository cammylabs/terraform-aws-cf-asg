/* launch config variables */

variable "lc-name-prefix" {}
variable "ami-id" {}
variable "instance-type" {}
variable "security-groups" {
  type = "list"
}

variable "iam-instance-profile" {}
variable "key-name" {}
variable "user-data" {}

/* associate a public ip address with an instance in a vpc */

variable "associate-public-ip-address" {
  default = true
}

/* asg config variables */

variable "asg-name" {}
variable "vpc-subnets" {}
variable "health-check-grace-period" {}
variable "asg-min-instance-size" {}
variable "asg-max-instance-size" {}
variable "asg-desired-instance-count" {}
variable "min-instances-in-service" {}
variable "max-update-batch-size" {}

variable "pause-time" {
  default = "PT0S"
}

variable "environment" {
  default = "unknown"
}
