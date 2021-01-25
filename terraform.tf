terraform {
  required_providers {
    azurerm = "=2.43.0"
  }
}

provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    features {}
}
