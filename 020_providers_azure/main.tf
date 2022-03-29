terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.0.2"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    resource_group {
      prevent_deletion_if_contains_resources=false
    }
  }
}

# Create a virtual network within the resource group
resource "azurerm_resource_group" "terraform_azure_providers" {
  name = "terraform_azure_providers"
  location = "australiaeast"
}

module "linuxservers" {
  source              = "Azure/compute/azurerm"
  location            = "australiaeast"   
  resource_group_name = azurerm_resource_group.terraform_azure_providers.name
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["mysimplevmips"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]
  vm_size            = "Standard_B1ls"   
  depends_on = [azurerm_resource_group.terraform_azure_providers]
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.terraform_azure_providers.name
  subnet_prefixes     = ["10.0.2.0/24"]
  subnet_names        = ["subnet2"]

  depends_on = [azurerm_resource_group.terraform_azure_providers]
}

output "linux_vm_public_name" {
  value = module.linuxservers.public_ip_dns_name
}