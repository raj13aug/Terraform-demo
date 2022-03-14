variable "web_apps" {
  type        = any
  description = "List of App service to create"
}

variable "location" {
  type        = string
  description = "Input name of the aws location."
}
