output "aws_ec2_instance" {
  value = {
    ip = aws_instance.web.public_ip
  }
}