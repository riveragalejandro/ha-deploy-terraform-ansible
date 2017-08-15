resource "aws_route53_record" "${var.name}" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name = "${var.name}.wecodeforfood.com"
  type = "A"
  ttl = "300"
  records = ["${aws_eip.lb.public_ip}"]
}
