output "namespace_id" {
  description = "Service Bus namespace ID"
  value = var.existing_servicebus_namespace_name != "" ? (
    data.azurerm_servicebus_namespace.existing[0].id
  ) : azurerm_servicebus_namespace.main[0].id
}

output "namespace_name" {
  description = "Service Bus namespace name"
  value = var.existing_servicebus_namespace_name != "" ? (
    data.azurerm_servicebus_namespace.existing[0].name
  ) : azurerm_servicebus_namespace.main[0].name
}

output "queue_id" {
  description = "Existing Service Bus queue ID"
  value = var.existing_servicebus_queue_name != "" ? (
    data.azurerm_servicebus_queue.existing[0].id
  ) : null
}

output "queue_name" {
  description = "Existing Service Bus queue name"
  value = var.existing_servicebus_queue_name != "" ? (
    data.azurerm_servicebus_queue.existing[0].name
  ) : null
}
