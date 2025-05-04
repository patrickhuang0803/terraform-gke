#-----------------------------------------------------------#
#                       Router & NAT                        #
#-----------------------------------------------------------#

resource "google_compute_router" "gke_router" {
  name    = "${var.cluster}-nat-router"
  network = var.network
  region  = var.location
}

resource "google_compute_router_nat" "gke_nat" {
  name                                = "${var.cluster}-nat"
  router                              = google_compute_router.gke_router.name
  region                              = var.location
  enable_endpoint_independent_mapping = false
  nat_ip_allocate_option              = "MANUAL_ONLY"
  nat_ips                             = [data.google_compute_address.gke_nat_ip.id]
  source_subnetwork_ip_ranges_to_nat  = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.default.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
