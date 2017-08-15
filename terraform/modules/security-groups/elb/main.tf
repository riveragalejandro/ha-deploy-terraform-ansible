# ELB Security Group

resource "aws_security_group" "elb" {
  name = "${var.name}-${var.env}-elb"
  description = "ELB Security Group for ${var.name} ${var.env}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.ingress_cidr_blocks}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.egress_cidr_blocks}"]
  }
}

output "elb_id" {value = "${aws_security_group.elb.id}"}
