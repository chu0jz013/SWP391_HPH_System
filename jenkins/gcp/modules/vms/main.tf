resource "google_compute_instance" "this" {
  name         = "${var.name}-vm"
  machine_type = var.machine_type
  zone         = var.zone
  boot_disk {
    initialize_params {
      image  = var.disk_image
      size   = var.disk_size
      labels = var.disk_labels
      type   = var.disk_type
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {
      nat_ip = var.nat_ip
    }
  }

  tags = var.tags

  metadata_startup_script = var.metadata_startup_script

  # SPOT INSTANCE
  scheduling {
    preemptible       = var.preemptible
    automatic_restart = var.automatic_restart
  }
}
