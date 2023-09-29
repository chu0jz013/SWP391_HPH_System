module "vpc" {
  source                 = "../modules/vpc"
  for_each               = try(local.configuration.network, {})
  name                   = try(each.value.name, null)
  subnet_ip_cidr_range   = try(each.value.subnet_ip_cidr_range, null)
  firewall_source_ranges = try(each.value.firewall_source_ranges, null)
  firewall_protocol      = try(each.value.firewall_protocol, null)
}


module "gke" {
  source             = "../modules/gke"
  for_each           = try(local.configuration.cluster, {})
  name               = try(each.value.name, null)
  machine_type       = try(each.value.machine_type, null)
  network            = try(each.value.network, module.vpc["vpc"].network_self_link)
  subnetwork         = try(each.value.network, module.vpc["vpc"].subnet_self_link)
  min_node_count     = try(each.value.min_count, null)
  max_node_count     = try(each.value.max_count, null)
  disk_size          = try(each.value.disk_size, null)
  initial_node_count = try(each.value.initial_node_count, null)

  depends_on = [module.vpc]
}
