output "db_private_vpc_id" {
  description = "Output DB Private VPC ID"
  value       = aws_vpc.vpc_db.id
}

output "db_private_sub_ids" {
  description = "Output DB Private Subnets IDs"
  value       = aws_subnet.private_subnet_db[*].id
}