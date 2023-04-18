# Creating Security Group for load balancer
resource "aws_security_group" "alb_sg" {
  name        = "alb_challenge_sg"
  description = "traffic from the internet"
  vpc_id      = aws_vpc.challenge_vpc.id
  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port   = var.port_ingress-01
    to_port     = var.port_ingress-01
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
  #HTTPS access from anywhere
  ingress {
    from_port   = var.port_ingress-02
    to_port     = var.port_ingress-02
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
  #SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }
}