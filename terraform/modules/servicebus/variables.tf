variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the Service Bus namespace."
  type        = string
}

variable "existing_servicebus_namespace_name" {
  description = "Existing Azure Service Bus namespace."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to newly created resources."
  type        = map(string)
  default     = {}
}

variable "existing_servicebus_queue_name" {
  description = "Existing Azure Service Bus queue."
  type        = string
  default     = ""
}
