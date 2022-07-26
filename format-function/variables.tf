variable "aws_region" {
  type    = string
  default = "us-east-2"
}

#Concatanate variables with string

variable "env_name" {
  default = "Dev_Server_"
}

variable "aws_instance_names" {
  default = [
    "AD01",
    "AD02",
  ]
}
