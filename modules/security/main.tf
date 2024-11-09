resource "aws_security_group" "db_security_group" {
  name        = "db_security_group"
  description = "Allow database access from specific IPs"
  vpc_id      = var.vpc_id  # Use the passed VPC ID

  # Allow access from your local IP to Aurora's port (3306 for MySQL/PostgreSQL)
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    cidr_blocks = ["0.0.0.0/0"]
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
