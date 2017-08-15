resource "aws_key_pair" "key" {
  key_name = "${var.name}"
  public_key = "${var.key}"
}

output "ec2key_name" {value = "${aws_key_pair.key.key_name}"}
