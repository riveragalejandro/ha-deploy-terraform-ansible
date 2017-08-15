# RDS Security Group
resource "aws_security_group" "rds" {
  name = "${var.name}-${var.env}-rds"
  description = "RDS Security group for ${var.name} ${var.env}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 3306
    to_port = 3306
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

output "rds_id" {value = "${aws_security_group.rds.id}"}
