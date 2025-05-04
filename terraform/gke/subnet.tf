#-----------------------------------------------------------#
#                        VPC Subnet                         #
#-----------------------------------------------------------#

resource "google_compute_subnetwork" "default" {
  name                     = var.cluster
  network                  = var.network
  region                   = var.location
  ip_cidr_range            = var.node_cidr
  private_ip_google_access = true
  description              = "auto-created subnetwork for cluster \"monitoring\""
}
