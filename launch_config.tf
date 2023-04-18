resource "aws_launch_configuration" "challenge_config" {
  name                        = "challenge_config-001"
  image_id                    = "ami-007855ac798b5175e"
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  security_groups             = ["${aws_security_group.challenge_ec2_sg.id}"]
  associate_public_ip_address = true
  user_data                   = file("user_data.sh")
  lifecycle {
    create_before_destroy = true
  }
}