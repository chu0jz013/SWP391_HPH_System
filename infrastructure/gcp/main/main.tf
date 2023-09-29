module "vpc" {
  source                 = "../modules/vpc"
  for_each               = try(local.configuration.network, {})
  name                   = try(each.value.name, null)
  subnet_ip_cidr_range   = try(each.value.subnet_ip_cidr_range, null)
  firewall_source_ranges = try(each.value.firewall_source_ranges, null)
  firewall_protocol      = try(each.value.firewall_protocol, null)
}


module "VMs" {
  source                  = "../modules/vms"
  depends_on              = [module.vpc]
  for_each                = try(local.configuration.VMs, {})
  name                    = try(each.value.name, null)
  disk_image              = try(each.value.disk_image, null)
  network                 = try(each.value.network, module.vpc["vpc"].network_self_link)
  subnetwork              = try(each.value.subnetwork, module.vpc["vpc"].subnet_self_link)
  nat_ip                  = try(each.value.nat_ip, module.vpc["vpc"].static_ip)
  metadata_startup_script = try(each.value.metadata_startup_script, null)
  tags                    = try(each.value.tags, null)
  zone                    = try(each.value.zone, null)
  machine_type            = try(each.value.machine_type, null)
  disk_size               = try(each.value.disk_size, null)
  disk_labels             = try(each.value.disk_labels, null)
  disk_type               = try(each.value.disk_type, null)
  preemptible             = try(each.value.spot == true ? true : each.value.spot == false ? false : null, null) # SPOT
  automatic_restart       = try(each.value.spot == true ? false : each.value.spot == false ? true : null, null) # SPOT

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
