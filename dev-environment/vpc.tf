data "aws_vpc" "selected" {
  default = true
}

data "aws_subnets" "mysubnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}
