output "asg-name" {
  value = "${aws_cloudformation_stack.asg.outputs["AsgName"]}"
}

output "launch-config-id" {
  value = "${aws_launch_configuration.lc.id}"
}
