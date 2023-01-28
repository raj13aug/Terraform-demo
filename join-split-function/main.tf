
####### Join ############

variable "string-value" {
  default = "function"
}

locals {
  s1  = "join"
  str = join("-", ["concatenation", "through", local.s1, var.string-value])
}

output "join-output" {
  value = local.str
}

####### Split ############

variable "ip_addresses" {
  default = "192.168.0.1,192.168.0.2,192.168.0.3"
}


output "middle_ip" {
  value = split(",", var.ip_addresses)[1]
}

##########################
