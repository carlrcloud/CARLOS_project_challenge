resource "aws_autoscaling_group" "challenge_asg" {
  name                      = "${aws_launch_configuration.challenge_config.name}-asg"
  min_size                  = 2
  desired_capacity          = 2
  max_size                  = 4
  health_check_grace_period = 100
  vpc_zone_identifier = [
    aws_subnet.challenge_pub_sub-01.id,
    aws_subnet.challenge_pub_sub-02.id
  ]

  health_check_type = "EC2"
  # target_group_arns    = [aws_lb_target_group.this.arn]
  launch_configuration = aws_launch_configuration.challenge_config.name
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  #Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}