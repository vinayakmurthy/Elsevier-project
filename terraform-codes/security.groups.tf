resource "aws_security_group" "elsesg" {
  name        = "elsevier-sg"
  description = "This security group allows you to connect the ec2 and allows on port http 80"

  tags = {
    project = "elsevier-proj"
  }
}

resource "aws_security_group_rule" "elsesg-ingress-apache" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  security_group_id = aws_security_group.elsesg.id
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elsesg-ingress-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  security_group_id = aws_security_group.elsesg.id
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elsesg-ingress-jenkins" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  security_group_id = aws_security_group.elsesg.id
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elsesg-egress-rule" {
  type              = "egress"
  to_port           = 0
  from_port         = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elsesg.id
}