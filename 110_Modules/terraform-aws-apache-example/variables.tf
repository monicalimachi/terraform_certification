variable "vpc_id" {
    type = string
    default="<VPC_ID>"
}

variable "subnet_id" {
    type = string
    default="<SUBNET_ID>"
}

variable "my_ip_with_cidr" {
  type = string
  description = "Provide your IP IP/32"
}


variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "server_name" {
  type = string
  default = "Apache Server"
}