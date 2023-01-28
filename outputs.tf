output "db_private_vpc_id" {
  description = "Output DB Private VPC ID"
  value       = [aws_vpc.vpc_db.id]
}

output "db_private_sub_ids" {
  description = "Output DB Private Subnets IDs"
  value       = [aws_subnet.private_subnet_db[0].id,aws_subnet.private_subnet_db[1].id,aws_subnet.private_subnet_db[2].id]
}