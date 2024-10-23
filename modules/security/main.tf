# resource "aws_security_group" "db_security_group" {
#   name        = "db_security_group"
#   description = "Allow database access"
#   vpc_id      = var.vpc_id  # Use the passed VPC ID

#   ingress {
#     from_port   = 3306  # Change to your database port
#     to_port     = 3306  # Change to your database port
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  # Change to your desired CIDR range
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "db_security_group"
#   }
# }

resource "aws_security_group" "db_security_group" {
  name        = "db_security_group"
  description = "Allow database access from a specific IP"
  vpc_id      = var.vpc_id  # Use the passed VPC ID

  # Allow access from your specific IP (49.47.0.102) to the database port 3306
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["49.47.0.102/32"]  # Allow access only from your public IP
  }

  # Allow all outbound traffic (required for RDS communication)
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
