# outputs.tf

# output "vpc_id" {
#   description = "The ID of the VPC created"
#   value       = module.networking.vpc_id
# }

# output "db_subnet_ids" {
#   description = "The private subnet IDs where the Aurora database is located"
#   value       = module.networking.db_subnet_ids
# }

# output "db_security_group_id" {
#   description = "The Security Group ID for the Aurora database"
#   value       = module.security.db_security_group_id
# }

# output "lambda_iam_role" {
#   description = "The ARN of the IAM role for Lambda"
#   value       = module.iam.lambda_iam_role
# }

# Updated: Referencing module.aurora outputs
# output "aurora_endpoint" {
#   description = "The endpoint of the Aurora Serverless cluster"
#   value       = module.aurora.aurora_endpoint
# }

# output "aurora_cluster_id" {
#   description = "The cluster ID of the Aurora Serverless database"
#   value       = module.aurora.aurora_cluster_id
# }
