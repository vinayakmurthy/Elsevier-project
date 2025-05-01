output "jenkins-access-ip" {
  value = "for jenkins access http:${aws_instance.ubuntu-instance.public_ip}:8080"
}

output "webserver-access-ip" {
  value = "for webserver access http:${aws_instance.ubuntu-instance.public_ip}:80"
}