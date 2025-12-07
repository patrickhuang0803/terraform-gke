#-----------------------------------------------------------#
#                       GKE Node Pool                       #
#-----------------------------------------------------------#

resource "google_container_node_pool" "default" {
  for_each = var.node_pool_configs

  name       = "${each.key}-pool"
  location   = var.location
  cluster    = google_container_cluster.default.name
  node_count = each.value["node_count"]

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  upgrade_settings {
    max_surge       = each.value["max_surge"]
    max_unavailable = each.value["max_unavailable"]
  }

  node_config {
    spot         = each.value["spot"]
    machine_type = each.value["machine_type"]
    disk_size_gb = each.value["disk_size_gb"]
    disk_type    = "pd-standard"
    image_type   = "COS_CONTAINERD"
    # Use default service account to enable pulling images in GCR
    service_account = var.service_account
    # Default oauth scopes (ref: https://cloud.google.com/sdk/gcloud/reference/container/node-pools/create#--scopes)
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only", # For pulling GCR images
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
    # Used for identifying resources, will be used in creating firewall rules.
    tags   = ["gke-${var.cluster}-${each.key}"]
    labels = each.key != "default" ? { "${each.key}" = "true" } : {}

    dynamic "taint" {
      for_each = each.key != "default" ? toset([each.key]) : toset([])
      content {
        key    = each.key
        value  = true
        effect = "NO_SCHEDULE"
      }
    }

    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = false
    }
  }
 
  timeouts {
    delete = "5m"
  }
}
