terraform {
  required_version = "1.3.1"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.26.0"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-e2etests-test"
    storage_account_name = "andonisa"
    container_name       = "terraformgithubexample"
    key                  = "terraformgithubexample.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "azapi" {}