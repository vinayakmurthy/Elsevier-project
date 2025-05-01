resource "aws_key_pair" "jenkins-key" {
  key_name   = "jenkins-key"
  public_key = file("./ssh-key/id_ed25519.pub")
}