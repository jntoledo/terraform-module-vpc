# ----------------------------------------------------------------------------------------------------------------------
# NACL - Public Subnet
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_network_acl" "public" {
  vpc_id     = "${module.vpc.vpc_id}"
  subnet_ids = ["${module.vpc.public_subnet_ids}"]

  tags = "${merge(local.common_tags, map("Name", "${var.environment} - public-subnet"))}"
}

resource "aws_network_acl_rule" "public_inbound_allow_all_tcp" {
  
  network_acl_id = "${aws_network_acl.public.id}"
  dynamic "ingress" {
    for_each = "${var.public_inbound_allow_all_tcp}"
    content { 
    rule_number    = "${ingress.value.rule_number}"
    protocol       = "${ingress.value.protocol}"
    rule_action    = "${ingress.value.rule_action}"
    cidr_block     = "${ingress.value.cidr_block}"
    from_port      = "${ingress.value.from_port}"
    to_port        = "${ingress.value.to_port}"
    }
  }
}


resource "aws_network_acl_rule" "public_outbound_allow_all_tcp" {
  network_acl_id = "${aws_network_acl.public.id}"
  dynamic "egress" {
    for_each = "${public_outbound_allow_all_tcp}"
    content { 
    egress         = "${egress.value.egress}" 
    rule_number    = "${egress.value.rule_number}"
    protocol       = "${egress.value.protocol}"
    rule_action    = "${egress.value.rule_action}"
    cidr_block     = "${egress.value.cidr_block}"
    from_port      = "${egress.value.from_port}"
    to_port        = "${egress.value.to_port}"
    }
  }
}

resource "aws_network_acl_rule" "public_inbound_allow_vpc" {
  network_acl_id = "${aws_network_acl.public.id}"
  dynamic "ingress" {
    for_each = "${var.public_inbound_allow_vpc}"
    content { 
    rule_number    = "${ingress.value.rule_number}"
    protocol       = "${ingress.value.protocol}"
    rule_action    = "${ingress.value.rule_action}"
    cidr_block     = "${ingress.value.cidr_block}"
    from_port      = "${ingress.value.from_port}"
    to_port        = "${ingress.value.to_port}"
    }
  }
}

resource "aws_network_acl_rule" "public_outbound_allow_vpc" {
  network_acl_id = "${aws_network_acl.public.id}"
  dynamic "egress" {
    for_each = "${var.public_outbound_allow_vpc}"
    content {
    egress         = "${egress.value.egress}"  
    rule_number    = "${egress.value.rule_number}"
    protocol       = "${egress.value.protocol}"
    rule_action    = "${egress.value.rule_action}"
    cidr_block     = "${egress.value.cidr_block}"
    from_port      = "${egress.value.from_port}"
    to_port        = "${egress.value.to_port}"
    }
  }
}

resource "aws_network_acl_rule" "public_inbound_allow_services_cidrs" {
  count = "${length(local.all_services_cidrs)}"

  network_acl_id = "${aws_network_acl.public.id}"
  dynamic "ingress" {
    for_each = "${var.public_inbound_allow_services_cidrs}"
    content { 
    rule_number    = "${ingress.value.rule_number}"
    protocol       = "${ingress.value.protocol}"
    rule_action    = "${ingress.value.rule_action}"
    cidr_block     = "${ingress.value.cidr_block}"
    from_port      = "${ingress.value.from_port}"
    to_port        = "${ingress.value.to_port}"
    }
  }
}

resource "aws_network_acl_rule" "public_outbound_allow_services_cidrs" {
  count = "${length(local.all_services_cidrs)}"

  network_acl_id = "${aws_network_acl.public.id}"
  dynamic "egress" {
    for_each = "${public_outbound_allow_services_cidrs}"
    content { 
    egress         = "${egress.value.egress}" 
    rule_number    = "${egress.value.rule_number}"
    protocol       = "${egress.value.protocol}"
    rule_action    = "${egress.value.rule_action}"
    cidr_block     = "${egress.value.cidr_block}"
    from_port      = "${egress.value.from_port}"
    to_port        = "${egress.value.to_port}"
    }
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# NACL - Private Subnet
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_network_acl" "private" {
  vpc_id     = "${module.vpc.vpc_id}"
  subnet_ids = ["${module.vpc.private_subnet_ids}"]

  tags = "${merge(local.common_tags, map("Name", "${var.environment} - private-subnet"))}"
}

resource "aws_network_acl_rule" "private_inbound_allow_vpc" {
  network_acl_id = "${aws_network_acl.private.id}"
  dynamic "ingress" {
    for_each = "${private_inbound_allow_vpc}"
    content { 
    rule_number    = "${ingress.value.rule_number}"
    protocol       = "${ingress.value.protocol}"
    rule_action    = "${ingress.value.rule_action}"
    cidr_block     = "${ingress.value.cidr_block}"
    from_port      = "${ingress.value.from_port}"
    to_port        = "${ingress.value.to_port}"
    }
  }
}

resource "aws_network_acl_rule" "private_outbound_allow_vpc" {
  network_acl_id = "${aws_network_acl.private.id}"
  dynamic "egress" {
    for_each = "${private_inbound_allow_vpc}"
    content {
    egress         = "${egress.value.egress}"  
    rule_number    = "${egress.value.rule_number}"
    protocol       = "${egress.value.protocol}"
    rule_action    = "${egress.value.rule_action}"
    cidr_block     = "${egress.value.cidr_block}"
    from_port      = "${egress.value.from_port}"
    to_port        = "${egress.value.to_port}"
    }
  }
}

resource "aws_network_acl_rule" "private_inbound_allow_proteus_cidrs" {
  count = "${length(var.proteus_services_cidrs)}"

  network_acl_id = "${aws_network_acl.private.id}"
  dynamic "ingress" {
    for_each = "${private_inbound_allow_proteus_cidrs}"
    content { 
    rule_number    = "${ingress.value.rule_number}"
    protocol       = "${ingress.value.protocol}"
    rule_action    = "${ingress.value.rule_action}"
    cidr_block     = "${ingress.value.cidr_block}"
    from_port      = "${ingress.value.from_port}"
    to_port        = "${ingress.value.to_port}"
    }
  }
}

resource "aws_network_acl_rule" "private_outbound_allow_proteus_cidrs" {
  count = "${length(var.proteus_services_cidrs)}"

  network_acl_id = "${aws_network_acl.private.id}"
  dynamic "egress" {
    for_each = "${private_outbound_allow_proteus_cidrs}"
    content {
    egress         = "${egress.value.egress}"  
    rule_number    = "${egress.value.rule_number}"
    protocol       = "${egress.value.protocol}"
    rule_action    = "${egress.value.rule_action}"
    cidr_block     = "${egress.value.cidr_block}"
    from_port      = "${egress.value.from_port}"
    to_port        = "${egress.value.to_port}"
    }
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# NACL - Database Subnet
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_network_acl" "database" {
  vpc_id     = "${module.vpc.vpc_id}"
  subnet_ids = ["${module.vpc.database_subnet_ids}"]

  tags = "${merge(local.common_tags, map("Name", "${var.environment} - database-subnet"))}"
}

resource "aws_network_acl_rule" "database_inbound_allow_vpc" {
  network_acl_id = "${aws_network_acl.database.id}"
  dynamic "ingress" {
    for_each = "${database_inbound_allow_vpc}"
    content { 
    rule_number    = "${ingress.value.rule_number}"
    protocol       = "${ingress.value.protocol}"
    rule_action    = "${ingress.value.rule_action}"
    cidr_block     = "${ingress.value.cidr_block}"
    from_port      = "${ingress.value.from_port}"
    to_port        = "${ingress.value.to_port}"
    }
  }
}
resource "aws_network_acl_rule" "database_outbound_allow_vpc" {
  network_acl_id = "${aws_network_acl.database.id}"
  dynamic "egress" {
    for_each = "${private_outbound_allow_proteus_cidrs}"
    content {
    egress         = "${egress.value.egress}"  
    rule_number    = "${egress.value.rule_number}"
    protocol       = "${egress.value.protocol}"
    rule_action    = "${egress.value.rule_action}"
    cidr_block     = "${egress.value.cidr_block}"
    from_port      = "${egress.value.from_port}"
    to_port        = "${egress.value.to_port}"
    }
  }
}