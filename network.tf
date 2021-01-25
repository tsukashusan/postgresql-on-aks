resource "azurerm_virtual_network" "example" {
    name                = var.virtualnetworkname
    address_space       = var.networkaddress
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name

    tags = {
        learning = "AzureStudy"
    }
}

resource "azurerm_role_assignment" "k8snetwork" {
  scope                = azurerm_resource_group.example.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.example.identity.0.principal_id
}