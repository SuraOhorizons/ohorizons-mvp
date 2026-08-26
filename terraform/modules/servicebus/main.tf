locals {
  servicebus_name = "sb-${var.existing_servicebus_namespace_name}"
}

data "azurerm_servicebus_namespace" "existing" {
  count               = var.existing_servicebus_namespace_name != "" ? 1 : 0
  name                = var.existing_servicebus_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_servicebus_namespace" "main" {
  count = var.existing_servicebus_namespace_name == "" ? 1 : 0

  name                = local.servicebus_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku      = "Standard"
  capacity = 0

  tags = var.tags
}

data "azurerm_servicebus_queue" "existing" {
  count        = var.existing_servicebus_queue_name != "" ? 1 : 0
  name         = var.existing_servicebus_queue_name
  namespace_id = data.azurerm_servicebus_namespace.existing[0].id
}
