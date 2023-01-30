variable "region" {
  type        = string
  description = "The AWS Region"
}

variable "region_number" {
  type = map(string)
  default = {
    us-east-1 = 1
    eu-west-1 = 2
  }
  description = "The AWS Regions"
}

variable "az_number" {
  type = map(string)
  default = {
    a = 1
    b = 2
    c = 3
    d = 4
    e = 5
    f = 6
  }
  description = "Assign a number to each AZ letter used in our configuration"
}


variable "environment" {
  type        = string
  description = "The deployment environment"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "pubkey"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags to apply to all resources"
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string
}

