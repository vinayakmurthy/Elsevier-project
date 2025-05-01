#Ec2 ubuntu machine with apache2 webserver setup
resource "aws_instance" "ubuntu-instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = var.instance_type.micro
  vpc_security_group_ids = [aws_security_group.elsesg.id]
  key_name               = aws_key_pair.elsekey.key_name
  availability_zone      = var.ZONE

  provisioner "file" {
    source      = "./scripts/web.sh"
    destination = "/tmp/web.sh"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./ssh-key/id_ed25519")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
}
