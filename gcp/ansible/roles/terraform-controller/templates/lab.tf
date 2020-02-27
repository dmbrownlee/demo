# Set the following environment variables to avoid interactive prompts:
#
#   export TF_VAR_gcp_json_key=<full path to json key file>
#   export TF_VAR_gcp_project=<GCP project ID>
#
#variable "gcp_json_key" {}
#variable "gcp_project" {}

provider "google" {
  credentials = file("{{ gcp_json_key }}")
  project     = "{{ ansible_env.GOOGLE_CLOUD_PROJECT }}"
  region      = "{{ gcp_region }}"
  zone        = "{{ gcp_zone }}"
}

resource "google_compute_instance" "{{ gcp_node1.name }}" {
  name         = "{{ gcp_node1.name }}"
  machine_type = "{{ gcp_node1.machine_type }}"

  boot_disk {
    initialize_params {
      image = "{{ gcp_node1.image }}"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}

resource "google_compute_instance" "{{ gcp_node2.name }}" {
  name         = "{{ gcp_node2.name }}"
  machine_type = "{{ gcp_node2.machine_type }}"

  boot_disk {
    initialize_params {
      image = "{{ gcp_node2.image }}"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}
