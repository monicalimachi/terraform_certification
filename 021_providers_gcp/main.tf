terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.15.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = "pacific-droplet-343123-742c30f69d28.json"
  project = "pacific-droplet-343123"
  region = "us-central1"
  zone = "us-central1-a"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-micro"
  #zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

}