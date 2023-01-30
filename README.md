# AWS VPC and Networking in depth

## Summary

# AWS VPC Networking.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network-eu"></a> [network-eu](#module\_network-eu) | ./local_modules/networking | n/a |
| <a name="module_network-us"></a> [network-us](#module\_network-us) | ./local_modules/networking | n/a |
| <a name="module_web-server"></a> [web-server](#module\_web-server) | ./local_modules/instance | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.node_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_ami.server_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_number"></a> [az\_number](#input\_az\_number) | Assign a number to each AZ letter used in our configuration | `map(string)` | <pre>{<br>  "a": 1,<br>  "b": 2,<br>  "c": 3,<br>  "d": 4,<br>  "e": 5,<br>  "f": 6<br>}</pre> | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags to apply to all resources | `map(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The deployment environment | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `string` | `"pubkey"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS Region | `string` | n/a | yes |
| <a name="input_region_number"></a> [region\_number](#input\_region\_number) | The AWS Regions | `map(string)` | <pre>{<br>  "eu-west-1": 2,<br>  "us-east-1": 1<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | n/a |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | The ID of the subnet |
<!-- END_TF_DOCS -->

