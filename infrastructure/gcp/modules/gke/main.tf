resource "google_container_cluster" "this" {

  name                     = "${var.name}-cluster"
  remove_default_node_pool = true
  network                  = var.network
  subnetwork               = var.subnetwork
  initial_node_count       = 1
  # cluster_ipv4_cidr         = var.cluster_ipv4_cidr
  # default_max_pods_per_node = var.default_max_pods_per_node
  resource_labels = {}
  # ip_allocation_policy { # forces replacement
  #   cluster_ipv4_cidr_block       = "10.104.0.0/14"
  #   cluster_secondary_range_name  = "gke-haikn2-cicd-sit-cluster-pods-6681f1fd"
  #   services_ipv4_cidr_block      = "10.108.0.0/20"
  #   services_secondary_range_name = "gke-haikn2-cicd-sit-cluster-services-6681f1fd"
  # }
}

resource "google_container_node_pool" "this" {
  name    = "${var.name}-node-pool"
  cluster = google_container_cluster.this.name

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    disk_size_gb = var.disk_size
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }
}
