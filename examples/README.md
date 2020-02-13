# VPC simples com ACLs de rede

A configuração neste diretório cria um conjunto de recursos de VPC junto com ACLs de rede para várias sub-redes.

As regras de rede ACL para tráfego de entrada e saída são definidas da seguinte maneira:
1. As sub-redes pública terão regras de ACL de rede fornecidas
1. As sub-redes privadas serão associadas às regras padrão da ACL da rede (a entrada e a saída somente IPV4 estão abertas para todos)

## Uso

Para executar este exemplo, você precisa executar:

```
$ terraform init
$ terraform plan
$ terraform apply
```

Observe que este exemplo pode criar recursos que podem custar dinheiro (AWS Elastic IP, por exemplo). Execute `terraform destroy` quando você não precisar desses recursos.

<!-- INÍCIO DE GANCHO DE DOCS TERRAFORM PRÉ-COMPROMISSO -->
## Provedores

Nenhum provedor.

## Entradas

Sem entrada.

## Saídas

| Nome | Descrição |
|------|-------------|
| default\_network\_acl\_id | The ID of the default network ACL |
| module\_vpc | Module VPC |
| private\_network\_acl\_id | ID of the private network ACL |
| private\_subnets | List of IDs of private subnets |
| public\_network\_acl\_id | ID of the public network ACL |
| public\_subnets | List of IDs of public subnets |
| vpc\_cidr\_block | The CIDR block of the VPC |
| vpc\_id | The ID of the VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
