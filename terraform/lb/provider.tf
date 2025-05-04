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
