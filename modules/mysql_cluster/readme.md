## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.8.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_mdb_mysql_cluster.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster) | resource |
| [yandex_vpc_subnet.cluster_subnets](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Имя кластера | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Version of the MySQL cluster. | `string` | `"8.0"` | no |
| <a name="input_ha"></a> [ha](#input\_ha) | Флаг для включения высокой доступности | `bool` | `false` | no |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID сети | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | n/a | <pre>list(object(<br/>    {<br/>      zone: string<br/>      cidr: string<br/>    }<br/>  ))</pre> | <pre>[<br/>  {<br/>    "cidr": "10.0.1.0/24",<br/>    "zone": "ru-central1-a"<br/>  },<br/>  {<br/>    "cidr": "10.0.2.0/24",<br/>    "zone": "ru-central1-b"<br/>  }<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Result cluster id |
