# Launch configuration module

resource "aws_launch_configuration" "launch_config" {
  name = "${var.name}"
  image_id = "${var.image_id}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = "${var.pub_ip}"
  iam_instance_profile = "${var.iam_instance_profile}"
  security_groups = ["${split(",", var.security_groups)}"]

  lifecycle {
    create_before_destroy = true
  }
}

output "launch_config_name" { value = "${aws_launch_configuration.launch_config.name}" }
