output "db_security_group_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.db_security_group.id  # Reference the security group's ID
}


output "ec2_security_group_id" {
  description = "The ID of the ec2 security group"
  value = aws_security_group.ec2_security_group.id
}
