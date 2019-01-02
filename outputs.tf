output "asg_name" {
  value = "${aws_cloudformation_stack.asg.outputs["AsgName"]}"
  type = "string"
}

output "launch_config_id" {
  value = "${aws_launch_configuration.lc.id}"
}
