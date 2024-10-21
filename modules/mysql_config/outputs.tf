output "user_password" {
  value = random_password.password
  description = "DB user password"
}
