# SSH Security Group

resource "aws_security_group" "ssh" {
  name = "${var.name}-${var.env}-ssh"
  description = "SSH Security group for ${var.name} ${var.env}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 22
    to_port = 22
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

output "ssh_id" {value = "${aws_security_group.ssh.id}"}
