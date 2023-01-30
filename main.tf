locals {
  requestor_cidr_blocks = var.is_enabled ? tolist(setsubtract([
    for k, v in data.aws_vpc.requestor.0.cidr_block_associations : v.cidr_block
  ], var.requestor_ignore_cidrs)) : []
  acceptor_cidr_blocks = var.is_enabled ? tolist(setsubtract([
    for k, v in data.aws_vpc.acceptor.0.cidr_block_associations : v.cidr_block
  ], var.acceptor_ignore_cidrs)) : []
}

resource "aws_vpc_peering_connection" "this" {
  count = var.is_enabled ? 1 : 0

  vpc_id      = join("", data.aws_vpc.requestor.*.id)
  peer_vpc_id = join("", data.aws_vpc.acceptor.*.id)

  /* peer_region = var.accepter_region */
  auto_accept = !var.auto_accept

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}

resource "aws_vpc_peering_connection_accepter" "this" {
  vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id
  auto_accept               = var.auto_accept
}

resource "aws_vpc_peering_connection_options" "this" {
  vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id

  accepter {
    allow_remote_vpc_dns_resolution = var.acceptor_allow_remote_vpc_dns_resolution
  }

  requester {
    allow_remote_vpc_dns_resolution = var.requestor_allow_remote_vpc_dns_resolution
  }
}

# Create routes from requestor to acceptor
resource "aws_route" "requestor" {
  count = var.is_enabled ? length(distinct(sort(data.aws_route_tables.requestor.0.ids))) * length(local.acceptor_cidr_blocks) : 0

  route_table_id = element(distinct(sort(data.aws_route_tables.requestor.0.ids)), ceil(count.index / length(local.acceptor_cidr_blocks)))

  destination_cidr_block = local.acceptor_cidr_blocks[count.index % length(local.acceptor_cidr_blocks)]

  vpc_peering_connection_id = join("", aws_vpc_peering_connection.this.*.id)

  depends_on = [data.aws_route_tables.requestor, aws_vpc_peering_connection.this]
}

# Create routes from acceptor to requestor
resource "aws_route" "acceptor" {
  count = var.is_enabled ? length(distinct(sort(data.aws_route_tables.acceptor.0.ids))) * length(local.requestor_cidr_blocks) : 0

  route_table_id = element(distinct(sort(data.aws_route_tables.acceptor.0.ids)), ceil(count.index / length(local.requestor_cidr_blocks)))

  destination_cidr_block = local.requestor_cidr_blocks[count.index % length(local.requestor_cidr_blocks)]

  vpc_peering_connection_id = join("", aws_vpc_peering_connection.this.*.id)

  depends_on = [data.aws_route_tables.acceptor, aws_vpc_peering_connection.this]
}