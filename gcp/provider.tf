terraform {
	required_providers {
		google = {
	    version = "~> 3.5.0"
		}
  }
}

provider "google" {
  project     = var.project
	region      = var.region
  credentials = var.gcp_creds
}
