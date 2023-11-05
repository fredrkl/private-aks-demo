resource "azurerm_public_ip" "bastion" {
  name                = "example-bastion-pip"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "example" {
  name                = "example-bastion"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  sku                 = "Standard"
  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }

  tunneling_enabled  = true
  copy_paste_enabled = true
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-vm"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

#resource "azurerm_windows_virtual_machine" "example" {
#  name                = "example-vm"
#  resource_group_name = var.resource_group.name
#  location            = var.resource_group.location
#  size                = "Standard_DS1_v2"
#  admin_username      = "adminuser"
#  admin_password      = var.jumphost_secret
#  network_interface_ids = [
#    azurerm_network_interface.example.id,
#  ]
#
#  os_disk {
#    caching              = "ReadWrite"
#    storage_account_type = "Standard_LRS"
#  }
#
#  source_image_reference {
#    publisher = "MicrosoftWindowsServer"
#    offer     = "WindowsServer"
#    sku       = "2019-Datacenter"
#    version   = "latest"
#  }
#}
