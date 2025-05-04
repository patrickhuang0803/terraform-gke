#------------------------------------------------------------#
#                      Get GKE NEG data                      #
#------------------------------------------------------------#

data "google_compute_network_endpoint_group" "default" {
  for_each = toset(var.node_locations)
  name     = var.neg_name
  zone     = each.key
}


#------------------------------------------------------------#
#                      Get fix IP data                       #
#------------------------------------------------------------#

data "google_compute_global_address" "gke_lb_ip" {
  name = "${var.prefix}-lb-ip"
}


