resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = var.container_registry_sku
  admin_enabled       = true
  tags = {
      learning = "AzureStudy"
  }
}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "k8s2acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.example.kubelet_identity.0.object_id
  # principal_id         = azurerm_kubernetes_cluster.example.service_principal[0].client_id
}