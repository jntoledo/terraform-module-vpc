# ----------------------------------------------------------------------------------------------------------------------
# NACL - Public Subnet
# ----------------------------------------------------------------------------------------------------------------------

variable "public_inbound_allow_all_tcp" {
  description = "Pública - Regras de entradas TCP"
  
  default = [
    {
  rule_number    = 50
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
    }
  ]
}

variable "public_outbound_allow_all_tcp" {
  description = "Pública - Regras de saídas TCP"
  
  default = [
    {
  egress         = true
  rule_number    = 50
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
    }
  ]
}

variable "public_inbound_allow_vpc" {
  description = "Pública - regras de entradas VPC"
  
  default = [
    {  
  rule_number    = 500
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "${module.vpc.cidr_block}"
  from_port      = 0
  to_port        = 0
    }
  ]
}


variable "public_outbound_allow_vpc" {
  description = "Pública - Regras de saídas VPC"
  
  default = [
    {
  egress         = true
  rule_number    = 500
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "${module.vpc.cidr_block}"
  from_port      = 0
  to_port        = 0
    }
  ]
}

# ----------------------------------------------------------------------------------------------------------------------
# NACL - Private Subnet
# ----------------------------------------------------------------------------------------------------------------------

variable "private_inbound_allow_vpc" {
  description = "Privado - Regras de entradas VPC"

  default = [
    {
  rule_number    = 500
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "${module.vpc.cidr_block}"
  from_port      = 0
  to_port        = 0
    }
  ]
}
variable "private_outbound_allow_vpc" {
  description = "Privado - Regras de entradas VPC"
    
  default = [
    {
  egress         = true
  rule_number    = 500
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "${module.vpc.cidr_block}"
  from_port      = 0
  to_port        = 0
    }
  ]
}

variable "private_inbound_allow_proteus_cidrs" {
  description = "Privado - Regras de entradas CIDRS"
  default = [
    { 
  rule_number    = "${100 + count.index}"
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "${element(var.proteus_services_cidrs, count.index)}"
  from_port      = 0
  to_port        = 0
    }
  ]
}

variable "private_outbound_allow_proteus_cidrs" {
  description = "Privado - Regras de saídas CIDRS"
  default = [
    {       
  egress         = true
  rule_number    = "${100 + count.index}"
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "${element(var.proteus_services_cidrs, count.index)}"
  from_port      = 0
  to_port        = 0
    }
  ]
}

# ----------------------------------------------------------------------------------------------------------------------
# NACL - Database Subnet
# ----------------------------------------------------------------------------------------------------------------------
variable "database_inbound_allow_vpc" {
  description = "Privado - Regras de entradas VPC/Database"
  default = [
    {    
  rule_number    = 500
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "${module.vpc.cidr_block}"
  from_port      = 0
  to_port        = 0
    }
  ]
}

variable "database_outbound_allow_vpc" {
  description = "Privado - Regras de saídas VPC/Database"
  default = [
    {    
  egress         = true
  rule_number    = 500
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "${module.vpc.cidr_block}"
  from_port      = 0
  to_port        = 0
    }
  ]
}