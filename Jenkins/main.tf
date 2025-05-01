resource "aws_instance" "jenkins-ubuntu" {
  ami                    = "ami-084568db4383264d4"
  key_name               = "jenkins-key"
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  instance_type          = "t2.small"
  availability_zone      = "us-east-1a"

  provisioner "file" {
    source      = "./scripts/jenkins-setup.sh"
    destination = "/tmp/jenkins-setup.sh"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./ssh-key/id_ed25519")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/jenkins-setup.sh",
      "sudo /tmp/jenkins-setup.sh"
    ]
  }
}