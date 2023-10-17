terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.51.0"
    }
  }
  # backend "gcs" {
  #   bucket = "haikn-infras-backend"
  #   prefix = "terraform/state"
  # }
}

provider "google" {
  # credentials = file("/home/haikn/key.json")
  project = "electric-charge-397303"
  region  = "asia-east2"
  zone    = "asia-east2-a"
}
