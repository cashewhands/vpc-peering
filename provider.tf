# provider.tf | Provider Configuration

provider "aws" {
  region = var.region

  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  region = "eu-west-1"
  alias  = "euw1"

  default_tags {
    tags = local.default_tags
  }
}
