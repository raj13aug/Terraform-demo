variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id" {
  type    = string
  default = "ami-09d56f8956ab235b3"

}

variable "key_name" {
  type    = string
  default = "Sundakkai_Technology"
}