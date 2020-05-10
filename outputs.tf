locals {
  subnet_ids  = local.private_count > 0 ? aws_subnet.private[*].id : aws_subnet.public[*].id
  aws_rt_ids  = local.private_count > 0 ? aws_route_table.private[*].id : aws_route_table.public[*].id
  subnet_arns = local.private_count > 0 ? aws_subnet.private[*].arn : aws_subnet.public[*].arn
  ngw_ids     = local.public_nat_gateways_count > 0 ? aws_nat_gateway.public[*].id : local.dummy_az_ngw_ids
}

output "az_subnet_ids" {
  value = zipmap(
    var.availability_zones,
    local.subnet_ids
  )
  description = "Map of AZ names to subnet IDs"
}

output "az_route_table_ids" {
  value = zipmap(
    var.availability_zones,
    local.aws_rt_ids
  )
  description = " Map of AZ names to Route Table IDs"
}

output "az_ngw_ids" {
  value = zipmap(
    var.availability_zones,
    local.ngw_ids
  )
  description = "Map of AZ names to NAT Gateway IDs (only for public subnets)"
}

output "az_subnet_arns" {
  value = zipmap(
    var.availability_zones,
    local.subnet_arns,
  )
  description = "Map of AZ names to subnet ARNs"
}
