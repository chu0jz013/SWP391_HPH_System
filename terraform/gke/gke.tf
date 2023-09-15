resource "google_container_cluster" "gke_cluster" {
  name     = "my-gke-cluster"
  location = "us-central1"

  node_pool {
    name       = "default-pool"
    node_count = 1
    machine_type = "n1-standard-1"
  }

  master_auth {
    username = "admin"
    password = "password"
  }
}

output "cluster_name" {
  value = google_container_cluster.gke_cluster.name
}
