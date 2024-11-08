provider "aws" {
  region = "ap-south-1"  # Specify your AWS region
}

module "networking" {
  source = "./modules/networking"  # Path to your networking module
}

module "security" {
  source = "./modules/security"     # Path to your security module
  vpc_id = module.networking.vpc_id  # Pass the VPC ID from the networking module
}

module "iam" {
  source = "./modules/iam"          # Path to your IAM module
}

module "ec2" {
  source    = "./modules/ec2"  # Path to your EC2 module
  vpc_id    = module.networking.vpc_id
  subnet_id = module.networking.db_subnet_ids[0]
  # Removed db_security_group_id and security_group_ids
}

module "aurora" {
  source                = "./modules/aurora"  # Path to your Aurora module
  vpc_id                = module.networking.vpc_id
  db_subnet_ids         = module.networking.db_subnet_ids
  db_security_group_id  = module.security.db_security_group_id
}

output "vpc_id" {
  description = "The ID of the VPC created"
  value       = module.networking.vpc_id
}

output "db_subnet_ids" {
  description = "The private subnet IDs where the Aurora database is located"
  value       = module.networking.db_subnet_ids
}

output "db_security_group_id" {
  description = "The Security Group ID for the Aurora database"
  value       = module.security.db_security_group_id
}

output "lambda_iam_role" {
  description = "The ARN of the IAM role for Lambda"
  value       = module.iam.lambda_iam_role
}

output "aurora_endpoint" {
  description = "The endpoint of the Aurora Serverless cluster"
  value       = module.aurora.aurora_endpoint
}

output "aurora_cluster_id" {
  description = "The cluster ID of the Aurora Serverless database"
  value       = module.aurora.aurora_cluster_id
}