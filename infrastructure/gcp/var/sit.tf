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

    # ##########################
    # # JENKINS Server
    # ##########################

    # VMs = {
    #   jenkins = {
    #     name                    = "${local.prefix_name}-sit-jenkins"
    #     disk_image              = "ubuntu-os-cloud/ubuntu-2004-lts"
    #     metadata_startup_script = file("../user_data/install_jenkins.sh")
    #     tags                    = ["jenkins-tag"]
    #     zone                    = "asia-east2-a"
    #     machine_type            = "e2-highcpu-8"
    #     disk_size               = "15"
    #     spot                    = true
    #   }
    # }

    ##########################
    # Kubernetes Cluster
    ##########################

    cluster = {
      gke = {
        name               = "${local.prefix_name}-k8s"
        machine_type       = "e2-medium"
        disk_size          = 12
        min_count          = 1
        max_count          = 5
        initial_node_count = 1
      }
    }
  }
}
