#-----------------------------------------------------------#
#                        GKE Cluster                        #
#-----------------------------------------------------------#

resource "google_container_cluster" "default" {
  name           = var.cluster
  network        = var.network
  location       = var.location
  node_locations = var.node_locations

  subnetwork      = google_compute_subnetwork.default.name
  networking_mode = "VPC_NATIVE"

  remove_default_node_pool = true
  initial_node_count       = 1

  private_cluster_config {
    enable_private_nodes   = true
    master_ipv4_cidr_block = "10.0.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "125.227.153.230/32"
    }
    cidr_blocks {
      cidr_block = "61.31.168.102/32"
    }
  }

  ip_allocation_policy {
    # Enables IP aliasing, making cluster VPC-native
    cluster_ipv4_cidr_block  = var.cluster_cidr
    services_ipv4_cidr_block = var.service_cidr
  }

  release_channel {
    channel = "UNSPECIFIED"
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }

  lifecycle {
    # Console created has value 0, but terraform created does not accept 0
    ignore_changes = [
      initial_node_count
    ]
  }
}
