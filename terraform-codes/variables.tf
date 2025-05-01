variable "my-ip" {
  default = "27.7.83.254/32" #please change the while running from your end 
}

variable "REGION" {
  default = "us-east-1"
}

variable "ZONE" {
  default = "us-east-1a"
}
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-084568db4383264d4"
    us-east-2 = "ami-04f167a56786e4b09"
  }
}

variable "instance_type" {
  type = map(string)
  default = {
    micro = "t2.micro"
    small = "t2.small"
    medium = "t2.medium"

  }

  
}