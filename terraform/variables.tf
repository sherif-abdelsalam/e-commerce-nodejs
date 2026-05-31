variable "region" {
  type    = string
}

variable "app_name" {
  type    = string
}


variable "environment" {
  type    = string
  default = "development"
}

variable "vpc_cidr" {
  type    = string
}

variable "instance_type" {
  type    = string
}

variable "app_port" {
  type    = number
}

variable "asg_min" {
  type    = number
}

variable "asg_max" {
  type    = number
}

variable "asg_desired" {
  type    = number
}