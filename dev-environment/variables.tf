variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "instance_count" {
  type = number
  default = 1
}

variable "environment" {
  type = string
  default = "development"
}

variable "min_instance" {
  type = number
}

variable "max_instance" {
  type = number
}

variable "domain_name" {
  # default = "bhavy.abhishekkothari.in"
  type = string
}

variable "subdomain_name" {
  default = "www"
  type = string
}