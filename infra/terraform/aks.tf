resource "azurerm_resource_group" "elastisys" {
  name     = "elastisys-resources"
  location = "North Europe"
  tags = {
    delete_me = "true"
  }
}

// ACR
resource "random_string" "acrname" {
    length  = 8
    special = false
    upper   = false
}

resource "azurerm_container_registry" "acr" {
  name                = random_string.acrname.result
  resource_group_name = azurerm_resource_group.elastisys.name
  location            = azurerm_resource_group.elastisys.location
  sku                 = "Premium"
  admin_enabled       = false
  tags = {
    delete_me = "true"
  }
}

// AKS with kubenet

resource "azurerm_kubernetes_cluster" "elastisys" {
  name                = "elastisys-aks1"
  location            = azurerm_resource_group.elastisys.location
  resource_group_name = azurerm_resource_group.elastisys.name
  dns_prefix          = "elastisysaks1"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    delete_me = "true"
  }
}

resource "azurerm_role_assignment" "elastisysacrpull" {
  principal_id                     = azurerm_kubernetes_cluster.elastisys.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
