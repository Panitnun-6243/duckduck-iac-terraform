variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location       = var.region
  version_prefix = "1.27."
}

resource "google_container_cluster" "primary" {
  name           = "${var.project_id}-gke"
  location       = var.zone
  node_locations = []

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name     = google_container_cluster.primary.name
  location = var.zone
  cluster  = google_container_cluster.primary.name

  version    = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.gke_num_nodes
  node_config {
    preemptible = true
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "e2-standard-2"
    tags         = ["gke-node", "${var.project_id}-gke"]
    disk_size_gb = 15
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
