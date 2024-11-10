variable "vpc_id" {
  description = "The ID of the VPC where the Aurora cluster will be created"
  type        = string
}

variable "db_subnet_ids" {
  description = "The IDs of the subnets for the Aurora cluster"
  type        = string
}

variable "ec2_subnet_id" {
  description = "The IDs of the subnets for the Aurora cluster"
  type        = string
}

variable "db_security_group_id" {
  description = "The ID of the database security group"
  type        = string
}
