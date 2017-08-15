# Auto scaling group module

resource "aws_autoscaling_group" "aws_asg" {
  name = "${var.asg_name}"
  availability_zones = ["${split(",", var.availability_zones)}"]
  load_balancers = ["${var.load_balancers}"]
  launch_configuration = "${var.launch_configuration_name}"
  min_size = "${var.min_size}"
  max_size = "${var.max_size}"
  vpc_zone_identifier = ["${var.vpc_zone_identifier}"]

  tags = [
    {
      key = "Name"
      value = "${var.instance_name}-${var.env}"
      Role = "${var.instance_name}-${var.env}"
      propagate_at_launch = true
    },
    {
      key = "Environment"
      value = "${var.env}"
      propagate_at_launch = true
    },
    {
      key = "Role"
      value = "${var.instance_name}-${var.env}"
      propagate_at_launch = true
    },
  ]

  lifecycle {
    create_before_destroy = true
  }
}

output "asg_name" {value = "${aws_autoscaling_group.aws_asg.name}"}
