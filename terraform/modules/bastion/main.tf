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
    subnet_id                     = var.subnet_jumphost_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-vm"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  disable_password_authentication = true

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

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.ssh_public_key
  }

  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_virtual_machine_extension" "AADSSHLoginForLinux" {
  name                       = "AADSSHLoginForLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.example.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADSSHLoginForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}
