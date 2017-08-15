# S3 bucket for storing app

resource "aws_s3_bucket" "s3bucket" {
  bucket = "wecodeforfood-org-${var.env}-${var.app_name}-bucket"
  acl = "private"
}

resource "aws_s3_bucket_object" "notejam-1" {
  bucket = "${aws_s3_bucket.s3bucket.bucket}"
  key = "notejam-1.0.tar.gz"
  source = "./files/notejam-1.0.tar.gz"
}

resource "aws_s3_bucket_object" "runserver" {
  bucket = "${aws_s3_bucket.s3bucket.bucket}"
  key = "runserver.sh"
  source = "./files/runserver.sh"
}

resource "aws_s3_bucket_object" "notejam-2" {
  bucket = "${aws_s3_bucket.s3bucket.bucket}"
  key = "notejam-2.0.tar.gz"
  source = "./files/notejam-2.0.tar.gz"
}
