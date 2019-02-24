resource "azurerm_virtual_network" "vnet" {
  name                = "${var.virtual_network_name}"
  location            = "${var.location}"
  address_space       = ["${var.address_space}"]
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_subnet" "subnetapi" {
  name                 = "edo-api-subnet"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefix       = "10.1.0.0/24"
}

resource "azurerm_subnet" "subnetdb" {
  name                 = "edo-db-subnet"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefix       = "10.1.1.0/28"
}

resource "azurerm_subnet" "subnetansible" {
  name                 = "edo-ansible-subnet"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefix       = "10.1.2.0/28"
}

resource "azurerm_public_ip" "ansibleip" {
  name                = "ansibleip"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "edoip" {
  name                = "edo-api-public-ip"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.lb_dns_name}"
}

resource "azurerm_lb" "lb" {
  name                = "edo-staging-lb"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  frontend_ip_configuration {
    name                 = "EdoLoadBalancerFrontEnd"
    public_ip_address_id = "${azurerm_public_ip.edoip.id}"
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  resource_group_name = "${azurerm_resource_group.rg.name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
  name                = "EdoApiBackendPool"
}

resource "azurerm_lb_rule" "lb_rule" {
  resource_group_name            = "${azurerm_resource_group.rg.name}"
  loadbalancer_id                = "${azurerm_lb.lb.id}"
  name                           = "edo-lb-rule-1"
  protocol                       = "tcp"
  frontend_port                  = 80
  backend_port                   = "${var.apiport}"
  frontend_ip_configuration_name = "EdoLoadBalancerFrontEnd"
  enable_floating_ip             = false
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.backend_pool.id}"
  idle_timeout_in_minutes        = 5
  probe_id                       = "${azurerm_lb_probe.lb_probe.id}"
  depends_on                     = ["azurerm_lb_probe.lb_probe"]
}

resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = "${azurerm_resource_group.rg.name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
  name                = "edoProbe"
  protocol            = "tcp"
  port                = "${var.apiport}"
  interval_in_seconds = 25
  number_of_probes    = 2
}

resource "azurerm_network_interface" "api-nic" {
  name                = "api-nic${count.index}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  count               = 2

  ip_configuration {
    name                                    = "api-ipconfig${count.index}"
    subnet_id                               = "${azurerm_subnet.subnetapi.id}"
    private_ip_address_allocation           = "Dynamic"
    load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.backend_pool.id}"]
  }
}

resource "azurerm_network_interface" "db-nic" {
  name                = "db-nic${count.index}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  count               = 1

  ip_configuration {
    name                          = "db-ipconfig${count.index}"
    subnet_id                     = "${azurerm_subnet.subnetdb.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "ansible-nic" {
  name                = "ansible-nic${count.index}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  count               = 1

  ip_configuration {
    name                          = "ansible-ipconfig${count.index}"
    subnet_id                     = "${azurerm_subnet.subnetansible.id}"
    private_ip_address_allocation = "Dynamic"
  }
}
