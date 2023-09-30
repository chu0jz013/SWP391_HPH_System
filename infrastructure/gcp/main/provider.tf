terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.51.0"
    }
  }
  backend "gcs" {
    bucket = "haikn-infras-backend"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "knhfrdevops"
  region  = "asia-east2"
  zone    = "asia-east2-a"
}
