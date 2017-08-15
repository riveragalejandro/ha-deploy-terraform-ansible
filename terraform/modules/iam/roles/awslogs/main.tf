# Policy for awslogs

resource "aws_iam_policy" "logs_policy" {
  name = "${var.env}-logs-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
    ],
      "Resource": [
        "arn:aws:logs:*:*:*"
    ]
  }
 ]
}
  EOF
}

data "aws_iam_policy_document" "logs_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "logs_role" {
  name = "logs-${var.env}-role"
  assume_role_policy = "${data.aws_iam_policy_document.logs_policy.json}"
}

resource "aws_iam_policy_attachment" "logs_policy_attachment" {
  name = "logs-${var.env}-attachment"
  roles = ["${aws_iam_role.logs_role.name}"]
  policy_arn = "${aws_iam_policy.logs_policy.arn}"
}
resource "aws_iam_instance_profile" "logs_profile" {
  name = "logs-${var.env}-profile"
  role = "${aws_iam_role.logs_role.name}"
}

output name {value = "${aws_iam_instance_profile.logs_profile.name}"}
