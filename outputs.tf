output "public_network_acl_id" {
  description = "ID of the public network ACL"
  value       = concat(aws_network_acl.public.*.id, [""])[0]
}

output "private_network_acl_id" {
  description = "ID of the private network ACL"
  value       = concat(aws_network_acl.private.*.id, [""])[0]
}

output "database_network_acl_id" {
  description = "ID of the database network ACL"
  value       = concat(aws_network_acl.database.*.id, [""])[0]
}
