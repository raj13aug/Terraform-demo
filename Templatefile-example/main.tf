terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  shared_credentials_file = "C:/Users/raj13/.aws/credentials"
  region                  = "us-east-1"
}

####################################
#EXAMPLE 1: INTERPOLATE VARIABLES#
####################################

/*
locals {
  name = "Lancer"
}

output "hello" {
  value = <<-EOF
    Mitsubishi, ${local.name}!
  EOF
}

*/


#######################################################
#EXAMPLE 2: INTERPOLATE VARIABLES IN A TEMPLATE_FILE ##
#######################################################

/*

data "template_file" "hello" {
  template = file("hello.tpl")
  vars = {
    name = "Mitsubishi Cedia"
  }
}

output "hello" {
  value = data.template_file.hello.rendered
}


*/

#####################################################################
#EXAMPLE 3: INTERPOLATE VARIABLES USING THE TEMPLATEFILE FUNCTION #
#####################################################################

/*

locals {
  hello = templatefile("hello.tpl", {
    name = "Mitsubishi Lancer"
  })
}

output "hello" {
  value = local.hello
}


*/
#########################
#EXAMPLE 4: THE FOR LOOP#
#########################


/*
locals {
  cars = ["lancer", "cedia", "pajero"]
}

output "cars" {
  value = <<-EOF
    My favourite cars are:
    %{for cars in local.cars~}
  - ${cars}
    %{endfor~}
  EOF
}

*/

############################################
#EXAMPLE 5: REFACTORE USING STRIP MARKERS#
############################################

/*

variable "name" {}

output "hello" {
  value = <<EOF
Hello, %{~if var.name != ""~}
 ${var.name}
%{~else~}
 cedia
%{~endif~}
!
EOF
}

*/

###################################
# EXAMPLE 6: IF ELSE ENDIF EXAMPLE #
###################################


variable "name" {}

output "hello" {
  value = <<-EOF
    Hello, %{if var.name != ""}${var.name}%{else}lancer%{endif}!
  EOF
}
