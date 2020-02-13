# Listas de controle de acesso à rede (ACL ou NACL)

## Este módulo pode gerenciar a ACL e as regras da rede. Depois que a VPC é criada, a AWS cria a ACL de rede padrão, que pode ser controlada usando este módulo.

## Além disso, cada tipo de sub-rede pode ter sua própria ACL de rede com regras personalizadas por sub-rede. Por exemplo, defina para usar a ACL de rede dedicada para as sub-redes públicas e liberar acessos TCP use public_inbound_allow_all_tcp; defina os valores de public_inbound_allow_all_tcp e public_outbound_allow_all_tcp para especificar todas as regras NACL que você precisa ter nas sub-redes públicas (consulte variable.tf para valores e estruturas padrão).