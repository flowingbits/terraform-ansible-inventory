variable "hosts" {
  type        = map(map(string))
  description = "List of hosts and their variables"
  default     = {}
}

variable "groups" {
  type        = map(list(string))
  description = "List of groups and hosts included"

  default = {}
}

variable "group_vars" {
  type        = map(map(string))
  description = "List of groups and their variables"

  default = {}
}

variable "group_children" {
  type        = map(list(string))
  description = "List of groups and children groups"

  default = {}
}

output "result" {
  value = templatefile(
    "${path.module}/inventory.tftpl",
    {
      hosts          = var.hosts
      groups         = var.groups
      group_vars     = var.group_vars
      group_children = var.group_children
    }
  )
}
