# Lookup requestor VPC so that we can reference the CIDR
data "aws_vpc" "requestor" {
  count = var.is_enabled ? 1 : 0
  id    = var.requestor_vpc_id
}

# Lookup acceptor VPC so that we can reference the CIDR
data "aws_vpc" "acceptor" {
  count = var.is_enabled ? 1 : 0
  id    = var.acceptor_vpc_id
}

data "aws_route_tables" "requestor" {
  count  = var.is_enabled ? 1 : 0
  vpc_id = join("", data.aws_vpc.requestor.*.id)
}

data "aws_route_tables" "acceptor" {
  count  = var.is_enabled ? 1 : 0
  vpc_id = join("", data.aws_vpc.acceptor.*.id)
}