output "network_self_link" {
  value = google_compute_network.this.self_link
}

output "subnet_self_link" {
  value = google_compute_subnetwork.this.self_link
}

output "static_ip" {
  value = google_compute_address.this.address
}
