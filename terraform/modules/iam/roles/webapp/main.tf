# Policy to access s3 and create logs

resource "aws_iam_policy" "webapp_policy" {
  name = "${var.env}-webapp-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": "*"
    },
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

data "aws_iam_policy_document" "webapp_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "webapp_role" {
  name = "webapp-${var.env}-role"
  assume_role_policy = "${data.aws_iam_policy_document.webapp_policy.json}"
}

resource "aws_iam_policy_attachment" "webapp_policy_attachment" {
  name = "webapp-${var.env}-attachment"
  roles = ["${aws_iam_role.webapp_role.name}"]
  policy_arn = "${aws_iam_policy.webapp_policy.arn}"
}
resource "aws_iam_instance_profile" "webapp_profile" {
  name = "webapp-${var.env}-profile"
  role = "${aws_iam_role.webapp_role.name}"
}

output name {value = "${aws_iam_instance_profile.webapp_profile.name}"}
