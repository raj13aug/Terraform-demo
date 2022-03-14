output "app_service_name" {
    value = [for app in aws_instance.app_server : app.tags.Name]
}