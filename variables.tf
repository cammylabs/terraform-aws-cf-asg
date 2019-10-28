/* launch config variables */

variable "lc_name_prefix" {
  description = "Creates a unique name beginning with this prefix"
}

variable "ami_id" {
}

variable "instance_type" {
}

variable "security_groups" {
  type        = list(string)
  description = "An array of security sg ids"
}

variable "iam_instance_profile" {
  description = "The ARN of the Instance Profile the LC should launch instances with"
}

variable "key_name" {
  description = "The name of a keypair"
}

variable "user_data" {
  description = "A string passed to the `user_data` field on EC2 boot"
}

/* associate a public ip address with an instance in a vpc */

variable "associate_public_ip_address" {
  default = true
}

/* asg config variables */

variable "asg_name" {
}

variable "vpc_subnets" {
}

variable "health_check_grace_period" {
  description = "Number of seconds to wait before checking the health status of instance"
}

variable "asg_min_instance_size" {
}

variable "asg_max_instance_size" {
}

variable "asg_desired_instance_count" {
}

variable "min_instances_in_service" {
  description = "Minimum required EC2 boxes to be running during a rolling update"
}

variable "max_update_batch_size" {
  description = "Maximum number of boxes to update at a single time during a rolling update"
}

variable "timeout_in_minutes" {
  default     = 30
  description = "The amount of time that can pass before the CF stack status becomes CREATE_FAILED"
}

variable "pause_time" {
  default     = "PT0S"
  description = "The amount of time to pause after making a change to a batch of instances"
}

variable "environment" {
  default     = "unknown"
  description = "A tag added to each EC2 instance in the ASG environment:unknown"
}

