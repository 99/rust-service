# resource "azurerm_kubernetes_cluster" "aks" {
#   name                = "${var.resource_group_name}-aks"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   dns_prefix          = "${var.resource_group_name}-dns"
#   default_node_pool {
#     name       = "default"
#     node_count = 1
#     vm_size    = "Standard_B2s" # will check which one is better "Standard_DS2_v2"
#   }
#   identity {
#     type = "SystemAssigned"
#   }
#   network_profile {
#     network_plugin    = "azure"
#     load_balancer_sku = "standard"
#   }
# }
