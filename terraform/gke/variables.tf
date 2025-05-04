#-----------------------------------------------------------#
#                      Required Params                      #
#-----------------------------------------------------------#
variable "project" {
  description = "The project ID where all resources will be launched."
  type        = string
}
variable "cluster" {
  description = "The name of the Kubernetes cluster."
  type        = string
}
variable "credentials" {
  description = "The path to GCP service account credentials"
  type        = string
}
variable "node_cidr" {
  description = "The IP CIDR range for Kubernetes nodes"
  type        = string
}
variable "cluster_cidr" {
  description = "The IP CIDR range for Kubernetes ClusterIPs"
  type        = string
}
variable "service_cidr" {
  description = "The IP CIDR range for Kubernetes Services"
  type        = string
}
variable "node_pool_configs" {
  description = "The map of the special config of node pool"
  type = map(object({
    machine_type    = string
    node_count      = number
    disk_size_gb    = number
    max_surge       = number
    max_unavailable = number
    spot            = bool
  }))
}

#-----------------------------------------------------------#
#                      Optional Params                      #
#-----------------------------------------------------------#
variable "network" {
  description = "The network where the Kubernetes cluster is connected."
  type        = string
  default     = "default"
}
variable "service_account" {
  description = "The service account is used for deploy GKE cluster by Terraform."
  type        = string
  default     = "default"
}
variable "location" {
  description = "The location (region or zone) of the GKE cluster."
  type        = string
  default     = "asia-east1"
}
variable "node_locations" {
  description = "The list of locations where the node pool is located."
  type        = list(string)
  default     = ["asia-east1-b", "asia-east1-c"]
}
