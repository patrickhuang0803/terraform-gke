#-----------------------------------------------------------#
#                         Terraform                         #
#-----------------------------------------------------------#

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.67.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.67.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.20.0"
    }
  }
  backend "gcs" {}
}

#-----------------------------------------------------------#
#                      Google Provider                      #
#-----------------------------------------------------------#

provider "google" {
  project     = var.project
  region      = var.location
  credentials = var.credentials
}

#------------------------------------------------------------#
#                        K8s Provider                        #
#------------------------------------------------------------#

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.default.endpoint}"
  cluster_ca_certificate = base64decode(data.google_container_cluster.default.master_auth.0.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}
