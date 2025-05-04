#------------------------------------------------------------#
#                    Used for K8s Provider                   #
#------------------------------------------------------------#

data "google_client_config" "default" {
  depends_on = [
    google_container_cluster.default,
    google_container_node_pool.default
  ]
}

data "google_container_cluster" "default" {
  name     = var.cluster
  location = var.location
  depends_on = [
    google_container_cluster.default,
    google_container_node_pool.default
  ]
}

#------------------------------------------------------------#
#                         Used for NAT                       #
#------------------------------------------------------------#

data "google_compute_address" "gke_nat_ip" {
  name = "${var.cluster}-nat-ip"
}
