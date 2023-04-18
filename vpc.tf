resource "aws_vpc" "challenge_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "challenge_vpc"
  }
}

resource "aws_internet_gateway" "challenge_gateway" {
  vpc_id = aws_vpc.challenge_vpc.id
}

# Creating 1st subnet 
resource "aws_subnet" "challenge_pub_sub-01" {
  vpc_id                  = aws_vpc.challenge_vpc.id
  cidr_block              = var.subnet_cidr[0]
  map_public_ip_on_launch = var.public_ip_on_launch
  availability_zone       = var.availability_zone[0]
  tags = {
    Name = "challenge_pub_sub-01"
  }
}
# Creating 2nd subnet 
resource "aws_subnet" "challenge_pub_sub-02" {
  vpc_id                  = aws_vpc.challenge_vpc.id
  cidr_block              = var.subnet_cidr[1]
  map_public_ip_on_launch = var.public_ip_on_launch
  availability_zone       = var.availability_zone[1]
  tags = {
    Name = "challenge_pub_sub-02"
  }
}

#Creating Route Table
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.challenge_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.challenge_gateway.id
  }
  tags = {
    Name = "Route to internet"
  }
}
resource "aws_route_table_association" "rt1" {
  subnet_id      = aws_subnet.challenge_pub_sub-01.id
  route_table_id = aws_route_table.route.id
}
resource "aws_route_table_association" "rt2" {
  subnet_id      = aws_subnet.challenge_pub_sub-02.id
  route_table_id = aws_route_table.route.id
}