resource "aws_instance" "webapp" {
  ami = "${var.ami_id}"
  vpc_security_group_ids = ["${split(",", var.security_group_ids)}"]
  key_name = "${var.key_name}"
  instance_type = "${var.instance_type}"
  count = "${var.count}"
  subnet_id = "${element(split(",", var.subnet_id), count.index%2)}"
  iam_instance_profile = "${var.webapp_profile}"

  tags {
    Name = "${var.name}-${var.env}-${count.index}"
    Environment = "${var.env}"
    Role = "${var.name}-${var.env}"
  }

  root_block_device {
    volume_type = "${var.volume_type}"
    volume_size = "${var.volume_size}"
    delete_on_termination = true
  }

  user_data = "${var.user_data}"

  provisioner "local-exec" {
  command = "echo Waiting for instance to become available...;sleep 300;cd ../../ansible ; ansible-playbook notejam-${var.env}.yml -i inventory/ec2.py --key-file ../terraform/modules/ec2/keys/${var.env}.pem -u ec2-user"
}

}

output "instance_id" {value = "${join(",", aws_instance.webapp.*.id)}"}
