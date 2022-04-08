variable "vpc_id" {
    type = string
    default="vpc-004e5430015965c54"
}

variable "subnet_id" {
    type = string
    default="subnet-08b95198d29acb21c"
}

variable "my_ip_with_cidr" {
  type = string
  description = "Provide your IP eg. 186.121.217.96/32"
}


variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "server_name" {
  type = string
  default = "Apache Server"
}