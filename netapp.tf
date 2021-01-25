resource "azurerm_subnet" "netappvolumesubnet" {
    name                 = "netapp"
    resource_group_name  = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes       = var.netappsubnet
    delegation {
        name = "delegation"
        service_delegation {
            name  = "Microsoft.Netapp/volumes"
            actions = ["Microsoft.Network/networkinterfaces/*","Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
        }
    }
}


resource "azurerm_netapp_account" "example" {
  name                = var.netapp-account-name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  tags = {
      learning = "AzureStudy"
  }
}

resource "azurerm_netapp_pool" "example" {
  name                = var.netapp-pool-name
  account_name        = azurerm_netapp_account.example.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  service_level       = var.netapp-pool-service_level
  size_in_tb          = var.netapp-size_in_tb
}

resource "azurerm_netapp_volume" "example" {
  lifecycle {
    prevent_destroy = true
  }
  name                = "k8s-netappvolume"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  account_name        = azurerm_netapp_account.example.name
  pool_name           = azurerm_netapp_pool.example.name
  volume_path         = var.volume_path
  service_level       = var.netapp-volume-service_level
  subnet_id           = azurerm_subnet.netappvolumesubnet.id
  protocols           = var.volume-protocols
  storage_quota_in_gb = var.storage_quota_in_gb
  export_policy_rule {
      rule_index = 1
      allowed_clients = azurerm_subnet.k8sdefaultnodesubnet.address_prefixes
      nfsv4_enabled = true
      unix_read_only    = false
      unix_read_write   = true
  }
}

#output "k8s-for-netapp-volume" {
##}