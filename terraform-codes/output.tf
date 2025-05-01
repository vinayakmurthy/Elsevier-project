output "webserver-access-ip" {
  value = "for webserver access http:${aws_instance.ubuntu-instance.public_ip}:80"
}