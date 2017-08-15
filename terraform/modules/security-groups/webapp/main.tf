# WEBAPP Security Group
resource "aws_security_group" "webapp" {
  name = "${var.name}-${var.env}-webapp"
  description = "WEBAPP Security Group for ${var.name} ${var.env}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${var.security_group_ids}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.egress_cidr_blocks}"]
  }
}

output "webapp_id" {value = "${aws_security_group.webapp.id}"}
