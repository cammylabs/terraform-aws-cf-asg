resource "aws_launch_configuration" "lc" {
  name_prefix          = var.lc_name_prefix
  image_id             = var.ami_id
  instance_type        = var.instance_type
  security_groups      = var.security_groups
  iam_instance_profile = var.iam_instance_profile
  key_name             = var.key_name
  user_data            = var.user_data

  associate_public_ip_address = var.associate_public_ip_address

  lifecycle {
    create_before_destroy = true
  }
}

// @see: https://github.com/hashicorp/terraform/issues/1552
resource "aws_cloudformation_stack" "asg" {
  name = var.asg_name

  timeout_in_minutes = var.timeout_in_minutes

  parameters = {
    LaunchConfigurationName = aws_launch_configuration.lc.name
    VPCZoneIdentifier       = var.vpc_subnets
    HealthCheckGracePeriod  = var.health_check_grace_period
  }

  template_body = <<EOF
{
  "Parameters": {
    "LaunchConfigurationName": {
      "Type": "String"
    },
    "VPCZoneIdentifier": {
      "Type": "CommaDelimitedList"
    },
    "HealthCheckGracePeriod": {
      "Type": "String"
    }
  },
  "Resources": {
    "Asg": {
      "Type": "AWS::AutoScaling::AutoScalingGroup",
      "Properties": {
        "LaunchConfigurationName": {"Ref": "LaunchConfigurationName"},
        "MaxSize":                 "${var.asg_max_instance_size}",
        "MinSize":                 "${var.asg_min_instance_size}",
        "DesiredCapacity":         "${var.asg_desired_instance_count}",
        "TerminationPolicies":     ["OldestLaunchConfiguration", "OldestInstance"],
        "VPCZoneIdentifier":       {"Ref": "VPCZoneIdentifier"},
        "HealthCheckGracePeriod":  {"Ref": "HealthCheckGracePeriod"},
        "Tags": [
          {
            "Key": "Name",
            "Value": "${var.asg_name}",
            "PropagateAtLaunch": "true"
          },
          {
            "Key": "Environment",
            "Value": "${var.environment}",
            "PropagateAtLaunch": "true"
          }
        ]
      },
      "UpdatePolicy": {
        "AutoScalingRollingUpdate": {
          "MinInstancesInService": "${var.min_instances_in_service}",
          "MaxBatchSize":          "${var.max_update_batch_size}",
          "PauseTime":             "${var.pause_time}"
        }
      }
    }
  },
  "Outputs": {
    "AsgName": {
      "Description": "The name of your auto scaling group",
      "Value": { "Ref": "Asg" }
    }
  }
}
EOF

}

