provider "ibm" {
  region           = var.region
  ibmcloud_timeout = 60
}

terraform {
  required_providers {
    ibm = {
      source  = "ibm-cloud/ibm"
      version = "~> 1.26"
    }
  }
  required_version = "> 1.0"
  experiments      = [module_variable_optional_attrs]
}