variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

locals {
  zone = "${var.region}-a"
}

# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location       = var.region
  version_prefix = "1.27."
}

resource "google_container_cluster" "primary" {
  name                     = "${var.project_id}-gke"
  location                 = local.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  # network    = google_compute_network.vpc.name
  # subnetwork = google_compute_subnetwork.subnet.name
  node_config {
    disk_size_gb = 60
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = local.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes
  # version    = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }
    disk_size_gb = 30

    machine_type = "e2-standard-2"
    tags         = ["gke-node", "${var.project_id}-gke"]

  }
}
