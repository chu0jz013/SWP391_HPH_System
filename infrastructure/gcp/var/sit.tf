locals {
  sit = {
    ##########################
    # VPC
    ##########################
    network = {
      vpc = {
        name                   = "${local.prefix_name}-sit"
        subnet_ip_cidr_range   = "10.0.0.0/24"
        firewall_source_ranges = ["0.0.0.0/0"]
        firewall_protocol      = "all"
      }
    }

    ##########################
    # Kubernetes Cluster
    ##########################

    cluster = {
      gke = {
        name               = "${local.prefix_name}-sit"
        machine_type       = "e2-medium"
        disk_size          = 12
        min_count          = 1
        max_count          = 5
        initial_node_count = 1
      }
    }
  }
}
