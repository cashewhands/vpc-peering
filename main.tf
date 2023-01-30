# main.tf | Main Configuration

resource "random_id" "node_id" {
  byte_length = 2
  keepers = {
    key_name = var.key_name
  }
}

module "network-us" {
  source   = "./local_modules/networking"
  vpc_cidr = var.vpc_cidr
}

module "network-eu" {
  source   = "./local_modules/networking"
  vpc_cidr = var.vpc_cidr

  providers = {
    aws = aws.euw1
  }
}

module "web-server" {
  source = "./local_modules/instance"

  depends_on = [module.network-us, module.network-eu]

  ami                         = data.aws_ami.server_ami.id
  instance_type               = var.instance_type
  subnet_id                   = module.network-us.public_subnet_id
  associate_public_ip_address = true
}
