# Creating Security Group for EC2

resource "aws_security_group" "challenge_ec2_sg" {
  name        = "challenge_ec2_sg"
  description = "traffic from alb to instances"
  vpc_id      = aws_vpc.challenge_vpc.id
  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    description = "TCP port for HTTP service"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}