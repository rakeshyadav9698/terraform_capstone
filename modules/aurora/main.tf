resource "aws_rds_cluster" "aurora" {
  cluster_identifier = "my-aurora-cluster"
  engine            = "aurora-mysql"  # Specify your Aurora engine type
  master_username   = "admin"
  master_password   = "Password123!"  # Use a secure way to manage sensitive information
  database_name     = "mydatabase"
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.db_security_group_id]
  db_subnet_group_name = aws_db_subnet_group.default.name

  tags = {
    Name = "my-aurora-cluster"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "aurora-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "aurora-subnet-group"
  }
}

# output "aurora_endpoint" {
#   value = aws_rds_cluster.aurora.endpoint
# }

# output "aurora_cluster_id" {
#   value = aws_rds_cluster.aurora.id
# }
