#------------------------------------------------------------#
#                        K8s storage                         #
#------------------------------------------------------------#

resource "kubernetes_storage_class" "regional-pd" {
  metadata {
    name = "regional-pd-ssd"
  }

  storage_provisioner    = "pd.csi.storage.gke.io"
  reclaim_policy         = "Delete"
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true

  parameters = {
    replication-type = "regional-pd"
    type             = "pd-ssd"
  }

  depends_on = [data.google_container_cluster.default]
}
