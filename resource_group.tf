resource "azurerm_resource_group" "example" {
  name     = var.resourcegroupname
  location = var.region
  tags = {
      learning = "AzureStudy"
  }
}