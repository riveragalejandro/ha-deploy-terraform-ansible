resource "aws_db_subnet_group" "rds_subnet" {
  name = "${var.name}-${var.env}-subnet-group"
  subnet_ids = ["${split(",", var.subnet_ids)}"]
}

resource "aws_db_instance" "rds" {
  identifier = "${var.name}-${var.env}-rds"
  allocated_storage = "${var.storage}"
  engine = "${var.engine}"
  engine_version = "${var.engine_version}"
  instance_class = "${var.instance_class}"
  name = "${var.name}"
  username = "${var.username}"
  password = "${var.password}"
  db_subnet_group_name = "${aws_db_subnet_group.rds_subnet.id}"
  vpc_security_group_ids = ["${split(",", var.security_group_ids)}"]
  skip_final_snapshot = "${var.skip_final_snapshot}"
  tags {
    Name = "${var.name}-${var.env}-rds"
    environment = "${var.env}"
  }
}

output "rds_ip" {value = "${aws_db_instance.rds.address}"}
