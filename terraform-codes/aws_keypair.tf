resource "aws_key_pair" "elsekey" {
  key_name   = "elsevier-key"
  public_key = file("./ssh-key/id_ed25519.pub")
}
