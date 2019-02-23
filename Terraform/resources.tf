resource "azurerm_resource_group" "edo-api-prod" {
  name = "edo-api-prod"
  location = "West Europe"
}

//TODO: Make more resurces on Azure

resource "azurerm_virtual_machine_scale_set" "edo-api-stack" {
  name = "edoapiprodscaleset"
  location = "West Europe"
  count = 2
  resource_group_name = "${azurerm_resource_group.edo-api-prod.name}"

  public_ip_address_configuration = {
    domain_name_label = "prod-edo-api",
    name = "prod-edo-api-ip-config"
  }
}
