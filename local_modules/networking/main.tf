# networking.tf | Network Configuration for vpc

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "public" {
  #checkov:skip=CKV_AWS_130: allow automatic public 1p assignment for testing

  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1)
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  #checkov:skip=CKV_AWS_130: allow automatic public 1p assignment for testing

  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 2)
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

/* resource "aws_route" "public" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
} */

resource "aws_eip" "gateway" {
  vpc        = true
  depends_on = [aws_internet_gateway.gateway]
} 