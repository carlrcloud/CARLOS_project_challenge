
resource "aws_lb" "challenge_alb" {
  name               = "challenge-alb1"
  load_balancer_type = "application"
  subnets = [
    "${aws_subnet.challenge_pub_sub-01.id}",
    "${aws_subnet.challenge_pub_sub-02.id}"
  ]
  security_groups = [aws_security_group.alb_sg.id]

  enable_cross_zone_load_balancing = true
}


resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.challenge_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.amazon_issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.challenge_target.arn
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.challenge_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "challenge_target" {
  name     = "challenge-tg1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.challenge_vpc.id
  # target_type = "alb"

  health_check {
    enabled  = true
    path     = "/"
    port     = 80
    matcher  = "200"
    timeout  = 120
    interval = 300
    unhealthy_threshold = 3
    healthy_threshold = 3
  }

  # health_check {
  #   healthy_threshold   = 2
  #   interval            = 30
  #   protocol            = "HTTP"
  #   unhealthy_threshold = 2
  # }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_attachment" "target" {
  autoscaling_group_name = aws_autoscaling_group.challenge_asg.name
  lb_target_group_arn    = aws_lb_target_group.challenge_target.arn
}

# resource "aws_lb_target_group_attachment" "webserver_asg_attachment" {
#   target_group_arn = aws_lb_target_group.this.arn
#   target_id        = aws_autoscaling_group.web.target_group_arns
# }










#  #Create a new load balancer
# resource "aws_elb" "terraform-elb" {
#   name               = "terraform-elb"
#   subnets = [aws_subnet.demosubnet.id, aws_subnet.demosubnet1.id]
#   security_groups = [aws_security_group.demosg1.id]

#   # access_logs {
#   #   bucket        = "foo"
#   #   bucket_prefix = "bar"
#   #   interval      = 60
#   # }

#   listener {
#     instance_port     = 80
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }

#   # listener {
#   #   instance_port      = 8000
#   #   instance_protocol  = "http"
#   #   lb_port            = 443
#   #   lb_protocol        = "https"
#   #   ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
#   # }

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     target              = "HTTP:80/"
#     interval            = 30
#   }
#   cross_zone_load_balancing   = true
#   idle_timeout                = 400
#   connection_draining         = true
#   connection_draining_timeout = 400

#   tags = {
#     Name = "foobar-terraform-elb"
#   }
# }





# # data "aws_acm_certificate" "this" {
# #   domain = "${var.dns_record_name}.${var.dns_zone_name}"
# # }





# # resource "aws_autoscaling_attachment" "example" {
# #   autoscaling_group_name = aws_autoscaling_group.web.name
# #   instance_id           = aws_instance.web.id
# # }











# # resource "aws_elb" "web_elb" {
# #   name = "web-elb"
# #   security_groups = [
# #     "${aws_security_group.demosg1.id}"
# #   ]
# #   subnets = [
# #     "${aws_subnet.demosubnet.id}",
# #     "${aws_subnet.demosubnet1.id}"
# #   ]
# # cross_zone_load_balancing   = true
# # health_check {
# #     healthy_threshold = 2
# #     unhealthy_threshold = 2
# #     timeout = 3
# #     interval = 30
# #     target = "HTTP:80/"
# #   }
# # listener {
# #     lb_port = 80
# #     lb_protocol = "http"
# #     instance_port = "80"
# #     instance_protocol = "http"
# #   }
# # }

# # resource "aws_lb" "challenge_alb" {
# #   name               = "challenge-alb"
# #   internal           = false
# #   load_balancer_type = "application"
# #   security_groups    = [aws_security_group.demosg1.id]

# #   subnets = [
# #     "${aws_subnet.demosubnet.id}",
# #     "${aws_subnet.demosubnet1.id}"
# #   ]
# # }