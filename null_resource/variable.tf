variable "location" {
  type        = string
  description = "Input name of the aws location."
  default     = "WestEurope"
 
  validation {
    condition     = can(index(["westeurope","us-west-2"], var.location))
    error_message = "The location must be westeurope or west."
  }
}