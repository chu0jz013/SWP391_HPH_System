resource "google_compute_network" "this" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "this" {
  name          = "${var.name}-subnet"
  network       = google_compute_network.this.self_link
  ip_cidr_range = var.subnet_ip_cidr_range # Specify the CIDR range for your subnet
}

resource "google_compute_firewall" "this" {
  name          = "${var.name}-firewall"
  network       = google_compute_network.this.name
  source_ranges = var.firewall_source_ranges
  allow {
    protocol = var.firewall_protocol
  }
}

resource "google_compute_address" "this" {
  name   = "${var.name}-staticip"
  region = "asia-east2"
}
