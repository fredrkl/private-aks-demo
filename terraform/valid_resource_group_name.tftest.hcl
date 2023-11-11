provider "azurerm" {
  features {}
}

variables {
  name_prefix            = "test"
  location               = "eastus"
  bastion_admin_password = "P@ssw0rd1234"
  ssh_public_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDinCyDXuX4I2KMVZjLEZFoBkVaXhEN/nCGTQtBLPy1s8NGZVosJ43aAYUA4bQ46V0lCGO5rZ2xTxRc5VgD8Gz4LVYC6Q4qMQppGlMtXeBtsOmJpjSCdbBNaVRDa/YAZeoiKVMl2XdaWPJKfIXBWsszbmpfveUDMZFeA8DVfZeBEpuxVx8v3G89KDOEhOMCSMqvZmqUROpClhL/Ea7biY9gWVC876rPc3tgmqVqNqrH+b5VT0YbFi7Vbhv4dEHHQhj0LXPAcPTjSPRra+aA3g7SWl+d9h4oyXoi/yWmgursy13pWQmeq67W86wsr/hDGufE+Xy2Hac0E91kkFgcbBb/1jted5JogelDbXS+4NbRtL/iiijOvKnoWDURpAnzyMSWFbgZbvQxOQZ35y0kQNwUSwImwsYP8GnvKmVkyRpYFSJv69l4kYH3lJb5jd/T16WB8Azkc8NnRlyusqp0K1lJtVlcLSQdlngpTncQhZtajpKtuZtZMIOJqmq3F6nhTX+7SliNdd0HJmv3MzlXDJzVIPv0V+iKHEc13CENaJFY8kiWTCaXHMbhMjuNlbGB35JzGlRejBQ0M1ujfycUI4YvmFlYOWydrpS5EUQYT3kDft6NZO2CBIDnZS+aGkpTUlQtVcxPSuvOgNCK0W7c0Ssv0oBOxPW99oniEg2Wdq9G5Q== fredrikklingenberg@Fredriks-MacBook-Pro.local"
}

run "valid_resource_group" {

  command = plan

  assert {
    condition     = azurerm_resource_group.aks.name == "test-private-aks"
    error_message = "Resource group name is not as expected"
  }
}
