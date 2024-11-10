resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true  # Enable DNS support
  enable_dns_hostnames = true  # Enable DNS hostnames
  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "vpc_private_subnet"
  }
}

resource "aws_subnet" "ec2_private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "vpc_ec2_private_subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main_vpc_igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "subnet_association" {
  count          = 2
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "subnet_ec2_association" {
  count          = 2
  subnet_id      = aws_subnet.ec2_private.id
  route_table_id = aws_route_table.public_route_table.id
}


output "vpc_id" {
  value = aws_vpc.main.id
}

output "db_subnet_ids" {
  value = aws_subnet.private.id
}

output "ec2_subnet_ids" {
  value = aws_subnet.ec2_private.id
}