variable "vpc_id" {
    type = string
    default="<VPC_ID>"
}

variable "my_ip_with_cidr" {
  type = string
  description = "YOUR_IP/32"
}


variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "server_name" {
  type = string
  default = "Apache Server"
}