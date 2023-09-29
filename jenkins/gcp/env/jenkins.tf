locals {
  jenkins = {
    ##########################
    # VPC
    ##########################
    network = {
      vpc = {
        name                   = "${local.prefix_name}-jenkins"
        subnet_ip_cidr_range   = "10.0.0.0/24"
        firewall_source_ranges = ["0.0.0.0/0"]
        firewall_protocol      = "all"
        firewall_ports          = ["8080", "9000"]
      }
    }

    ##########################
    # JENKINS Server
    ##########################

    VMs = {
      jenkins = {
        name                    = "${local.prefix_name}-jenkins"
        disk_image              = "ubuntu-os-cloud/ubuntu-2004-lts"
        metadata_startup_script = file("../user_data/install_jenkins.sh")
        tags                    = ["jenkins-tag"]
        zone                    = "asia-east2-a"
        machine_type            = "e2-highcpu-8"
        disk_size               = "15"
        spot                    = true
      }
    }
  }
}
