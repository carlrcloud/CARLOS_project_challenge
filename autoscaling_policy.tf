resource "aws_autoscaling_policy" "challenge_policy" {
  name                   = "policy"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.challenge_asg.name
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch" {
  alarm_name          = "terraform-test-foobar5"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 cpu utilization"
  dimensions = {
    "autoscaling_group_name" : aws_autoscaling_group.challenge_asg.name
  }
  actions_enabled           = true
  alarm_actions             = [aws_autoscaling_policy.challenge_policy.arn]
  insufficient_data_actions = []
}




# resource "aws_autoscaling_policy" "web_policy_up" {
#   name                   = "web_policy_up"
#   scaling_adjustment     = 1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
#   autoscaling_group_name = aws_autoscaling_group.web.name
# }


# resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
#   alarm_name          = "web_cpu_alarm_up"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "70"
#   dimensions = {
#     AutoScalingGroupName = "${aws_autoscaling_group.challenge_asg.name}"
#   }
#   alarm_description = "This metric monitor EC2 instance CPU utilization"
#   alarm_actions     = ["${aws_autoscaling_policy.challenge_policy.arn}"]
# }