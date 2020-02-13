# Network ACLs
output "public_network_acl_id" {
  description = "ID of the public network ACL"
  value       = module.vpc.public_network_acl_id
}

output "private_network_acl_id" {
  description = "ID of the private network ACL"
  value       = module.vpc.private_network_acl_id
}

output "elasticache_network_acl_id" {
  description = "ID of the elasticache network ACL"
  value       = module.vpc.elasticache_network_acl_id
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = module.vpc.default_network_acl_id
}

output "module_vpc" {
  description = "Module VPC"
  value       = module.vpc
}