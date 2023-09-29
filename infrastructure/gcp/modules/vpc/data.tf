# locals {
#   network_name                   = "kubernetes-cluster"
#   subnet_name                    = "${google_compute_network.vpc.name}--subnet"
#   cluster_master_ip_cidr_range   = "10.100.100.0/28"
#   cluster_pods_ip_cidr_range     = "10.101.0.0/16"
#   cluster_services_ip_cidr_range = "10.102.0.0/16"
# }