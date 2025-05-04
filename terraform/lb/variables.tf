#-----------------------------------------------------------#
#                      Required Params                      #
#-----------------------------------------------------------#
variable "project" {
  description = "The project ID where all resources will be launched."
  type        = string
}
variable "credentials" {
  description = "The path to GCP service account credentials."
  type        = string
}
variable "prefix" {
  description = "The prefix for LB objects"
  type        = string
}
variable "neg_name" {
  description = "The NEG name that is created GKE."
  type        = string
}

#-----------------------------------------------------------#
#                      Optional Params                      #
#-----------------------------------------------------------#
variable "network" {
  description = "The network where the Kubernetes cluster is connected."
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
