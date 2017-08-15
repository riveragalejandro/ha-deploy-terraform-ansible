resource "aws_elb" "elb" {
  name = "${var.name}-${var.env}-elb"
  security_groups = ["${var.security_groups}"]
  subnets = ["${split(",", var.subnets)}"]

  listener {
    instance_port = "${var.instance_port}"
    instance_protocol = "http"
    lb_port = "${var.lb_port}" 
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 5
    target ="${var.health_check_target}"
    interval = 15
  }

  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 300
  instances = ["${split(",", var.ec2_ids)}"] 
}
output "elb_dns" {value = "${aws_elb.elb.dns_name}"}
output "elb_id" {value = "${aws_elb.elb.zone_id}"}
output "elb_name" {value = "${aws_elb.elb.id}"}
