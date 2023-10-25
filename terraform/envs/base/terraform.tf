terraform {
    required_providers {
        azurerm = {
            source              = "hashicorp/azurerm"
            version             = ">=3.0.0"
        }
    }
    backend "azurerm" {
        resource_group_name     = "d1-base-RG"
        storage_account_name    = "d1baseterraformbackend"
        container_name          = "d1-base-terraform-backend"
        key                     = "prod.terraform.tfstate"
    }
}

provider "azurerm" {
    features {}
}