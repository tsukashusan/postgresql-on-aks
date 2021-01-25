resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}

resource "azurerm_log_analytics_workspace" "test" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = format("%s-%s" ,var.log_analytics_workspace_name, random_id.log_analytics_workspace_name_suffix.dec)
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "test" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.test.location
    resource_group_name   = azurerm_resource_group.example.name
    workspace_resource_id = azurerm_log_analytics_workspace.test.id
    workspace_name        = azurerm_log_analytics_workspace.test.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}

resource "azurerm_subnet" "k8sdefaultnodesubnet" {
    name                 = "k8s"
    resource_group_name  = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes       = var.k8ssubnet
}


resource "azurerm_kubernetes_cluster" "example" {
  name                = var.aksname
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks1"

  linux_profile {
      admin_username = "ubuntu"
  
      ssh_key {
          key_data = var.ssh_public_key
      }
  }

  default_node_pool {
    name       = var.aksnodepoolname
    node_count = var.aksnodepoolnodecount
    vm_size    = var.aksnodepoolvmsize
    vnet_subnet_id = azurerm_subnet.k8sdefaultnodesubnet.id
  }

  identity {
    type = "SystemAssigned"
  }
  
  addon_profile {
      oms_agent {
        enabled                    = var.aksaddon-oms-enable
        log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
      }
  }
  
  network_profile {
      load_balancer_sku = "Standard"
      network_plugin    = "azure"
      network_policy    = "azure"
      network_mode      = "transparent"
  }

  tags = {
    Environment = "Production"
  }
}


output "kube" {
  value = azurerm_kubernetes_cluster.example
}
