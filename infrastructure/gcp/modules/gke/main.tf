resource "google_container_cluster" "this" {

  name                     = "${var.name}-cluster"
  remove_default_node_pool = true
  network                  = var.network
  subnetwork               = var.subnetwork
  initial_node_count       = 1
  # cluster_ipv4_cidr         = var.cluster_ipv4_cidr
  # default_max_pods_per_node = var.default_max_pods_per_node
  resource_labels = {}
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
