resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "private" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "private_subnet_${count.index}"
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
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

data "aws_availability_zones" "available" {}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "db_subnet_ids" {
  value = aws_subnet.private[*].id
}

resource "aws_security_group" "db_security_group" {
  name        = "db_security_group"
  description = "Allow database access from specific IPs"
  vpc_id      = var.vpc_id  # Use the passed VPC ID

  # Allow access from your local IP to Aurora's port (3306 for MySQL/PostgreSQL)
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["49.47.2.213/32"]
  }

  # Allow all outbound traffic for the RDS service
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db_security_group"
  }
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Allow SSH access from a specific IP"
  vpc_id      = var.vpc_id  # Use the passed VPC ID

  # Allow SSH access from your local IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.47.2.213/32"]
  }

  # Allow outbound traffic for the EC2 instance
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_security_group"
  }
}

output "db_security_group_id" {
  value = aws_security_group.db_security_group.id
}

output "ec2_security_group_id" {
  value = aws_security_group.ec2_security_group.id
}
