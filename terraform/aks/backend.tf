terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatelabor"
    container_name       = "tfstate"
    key                  = "labor.terraform.tfstate"
  }
}
