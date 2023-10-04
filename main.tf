terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "high_number_of_apache_child_processes_incident" {
  source    = "./modules/high_number_of_apache_child_processes_incident"

  providers = {
    shoreline = shoreline
  }
}