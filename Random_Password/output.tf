output "password" {
  description = "The password is:" 
  value = random_password.password.*.result
  sensitive = true
}