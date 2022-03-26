

variable "location" {
  type        = string
  description = "Input name of the aws location."
}

variable "ingressrules" {
  type    = list(number)
  default = [80, 443]

}

variable "engressrules" {
  type    = list(number)
  default = [80, 443, 25, 3360]

}