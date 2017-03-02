resource "aws_launch_configuration" "lc" {
  name_prefix                 = "${var.lc-name-prefix}"
  image_id                    = "${var.ami-id}"
  instance_type               = "${var.instance-type}"
  security_groups             = ["${var.security-groups}"]
  iam_instance_profile        = "${var.iam-instance-profile}"
  key_name                    = "${var.key-name}"
  user_data                   = "${var.user-data}"

  associate_public_ip_address = "${var.associate-public-ip-address}"

  lifecycle {
    create_before_destroy     = true
  }
}

// @see: https://github.com/hashicorp/terraform/issues/1552
resource "aws_cloudformation_stack" "asg" {
  name = "${var.asg-name}"
  parameters {
    LaunchConfigurationName = "${aws_launch_configuration.lc.name}"
    VPCZoneIdentifier       = "${var.vpc-subnets}"
    HealthCheckGracePeriod  = "${var.health-check-grace-period}"
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
    "EcsAsg": {
      "Type": "AWS::AutoScaling::AutoScalingGroup",
      "Properties": {
        "LaunchConfigurationName": {"Ref": "LaunchConfigurationName"},
        "MaxSize":                 "${var.asg-max-instance-size}",
        "MinSize":                 "${var.asg-min-instance-size}",
        "DesiredCapacity":         "${var.asg-desired-instance-count}",
        "TerminationPolicies":     ["OldestLaunchConfiguration", "OldestInstance"],
        "VPCZoneIdentifier":       {"Ref": "VPCZoneIdentifier"},
        "HealthCheckGracePeriod":  {"Ref": "HealthCheckGracePeriod"},
        "Tags": [
          {
            "Key": "Name",
            "Value": "${var.asg-name}",
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
          "MinInstancesInService": "${var.min-instances-in-service}",
          "MaxBatchSize":          "${var.max-update-batch-size}",
          "PauseTime":             "PT0S"
        }
      }
    }
  },
  "Outputs": {
    "AsgName": {
      "Description": "The name of your auto scaling group",
      "Value": { "Ref": "EcsAsg" }
    }
  }
}
EOF
}
