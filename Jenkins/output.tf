output "jenkins-pubIP" {
  value = "Access the jenkins website at ${aws_instance.jenkins-ubuntu.public_ip}:8080"
}