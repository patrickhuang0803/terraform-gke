#------------------------------------------------------------#
#                       Firewall Rules                       #
#------------------------------------------------------------#

resource "google_compute_firewall" "default" {
  name    = "${var.prefix}-firewall"
  network = var.network

  direction = "INGRESS"

  source_ranges = ["source_range1", "source_range2"]

  allow {
    protocol = "all"
  }
}
