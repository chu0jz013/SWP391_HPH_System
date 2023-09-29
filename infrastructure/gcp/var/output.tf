output "configuration" {
  value = local.file_name["${var.file_name}"]
}

output "global_variables" {
  value = local.global_variables
}

output "tags" {
  value = local.tags
}