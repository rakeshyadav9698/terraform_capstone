
# Define variables for security group and subnet

variable "db_security_group_id" {
  description = "Security Group ID to associate with the EC2 instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the EC2 instance"
  type        = string
}


# EC2 instance resource

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0dee22c13ea7a9a67"  # Update with your preferred AMI
  instance_type          = "t2.micro"              # Choose an instance type
  subnet_id              = var.subnet_id           # Use the provided subnet ID
  vpc_security_group_ids = var.db_security_group_id  # Use the provided security group ID
  key_name               = "ubuntu-node-key-pair"
  associate_public_ip_address = true


  # Optional: Add tags for the instance
  tags = {
    Name = "MyEC2Instance"
  }
}

# Optional: Output the instance ID and public IP
output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ec2_instance.id
}

output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ec2_instance.public_ip
}
