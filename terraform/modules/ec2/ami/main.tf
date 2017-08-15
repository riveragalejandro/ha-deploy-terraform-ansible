# Create AMI Module

resource "aws_ami_from_instance" "ec2ami" {
  name = "${var.name}"
  source_instance_id = "${element(split(",", var.source_instance_id), 0)}"
}

output "ami_id" {value = "${aws_ami_from_instance.ec2ami.id}"}
