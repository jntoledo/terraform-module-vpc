# ----------------------------------------------------------------------------------------------------------------------
# NACL - Default ACL
# ----------------------------------------------------------------------------------------------------------------------
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