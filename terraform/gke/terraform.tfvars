cluster         = "patrick-monitoring"
network         = "default"
service_account = "default"
location        = "asia-east1"
node_locations  = ["asia-east1-b", "asia-east1-c"]
node_cidr       = "[NODE_CIDR]"
cluster_cidr    = "[CLUSTER_CIDR]"
service_cidr    = "[SERVICE_CIDR]"

node_pool_configs = {
  "default" : {
    machine_type    = "e2-small"
    node_count      = 1
    disk_size_gb    = 20
    max_surge       = 1
    max_unavailable = 1
    spot            = false
  },
  "monitoring" : {
    machine_type    = "e2-standard-2"
    node_count      = 1
    disk_size_gb    = 20
    max_surge       = 1
    max_unavailable = 0
    spot            = true
  },
  "logging" : {
    machine_type    = "e2-standard-2"
    node_count      = 1
    disk_size_gb    = 20
    max_surge       = 1
    max_unavailable = 0
    spot            = true
  },
  "spot-edges" : {
    machine_type    = "e2-small"
    node_count      = 1
    disk_size_gb    = 20
    max_surge       = 1
    max_unavailable = 0
    spot            = true
  }
}
