# Set the following environment variables to avoid interactive prompts:
#
#   export TF_VAR_gcp_json_key=<full path to json key file>
#   export TF_VAR_gcp_project=<GCP project ID>

variable "gcp_json_key" {}
variable "gcp_project" {}

provider "google" {
  credentials = file(var.gcp_json_key)
  project     = var.gcp_project
  region      = "us-west1"
  zone        = "us-west1-b"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "g1-small"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}
