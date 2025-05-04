#------------------------------------------------------------#
#                       Firewall Rules                       #
#------------------------------------------------------------#

resource "google_compute_firewall" "default" {
  name    = "${var.prefix}-firewall"
  network = var.network

  direction = "INGRESS"

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  allow {
    protocol = "all"
  }
}
