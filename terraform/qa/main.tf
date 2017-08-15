# Dev environment

# Provider

provider "aws" {}

# VPC

module "vpc" {
  source = "../modules/vpc"
  env = "${var.env}"
  vpc_cidr = "${var.vpc_cidr}"
  public_cidrs = "${var.public_cidrs}"
  private_cidrs = "${var.private_cidrs}"
}

# Security Groups

module "elb_sg" {
  source = "../modules/security-groups/elb"
  name = "${var.app_name}"
  env = "${var.env}"
  vpc_id = "${module.vpc.vpc_id}"
}

module "ssh_sg" {
  source = "../modules/security-groups/ssh"
  name = "${var.app_name}"
  env = "${var.env}"
  vpc_id = "${module.vpc.vpc_id}"
}

module "webapp_sg" {
  source = "../modules/security-groups/webapp"
  name = "${var.app_name}"
  env = "${var.env}"
  security_group_ids = "${module.elb_sg.elb_id}"
  vpc_id = "${module.vpc.vpc_id}"
}

module "rds_sg" {
  source = "../modules/security-groups/rds"
  name = "${var.app_name}"
  env = "${var.env}"
  security_group_ids = "${module.webapp_sg.webapp_id}"
  vpc_id = "${module.vpc.vpc_id}"
}

# IAM Profile for s3 and awslogs

module "webapp_profile" {
  source = "../modules/iam/roles/webapp"
  env = "${var.env}"
}

# SSH Keys

module "keys" {
  source = "../modules/ec2/keys"
  key = "${file("../modules/ec2/keys/${var.env}.pub")}"
  name = "${var.env}"
}

# RDS

module "rds" {
  source = "../modules/rds"
  name = "${var.app_name}"
  env = "${var.env}"
  storage = "5"
  db_name = "${var.dbname}"
  security_group_ids = "${module.rds_sg.rds_id}"
  subnet_ids = "${module.vpc.private_subnet_ids}"
  skip_final_snapshot = "true"
}

# WEBAPP

module "webapp" {
  source = "../modules/ec2/webapp"
  name = "${var.app_name}"
  env = "${var.env}"
  key_name = "${module.keys.ec2key_name}"
  count = "${var.instance_count}"
  security_group_ids = "${module.webapp_sg.webapp_id},${module.ssh_sg.ssh_id}"
  user_data = "${var.user_data}" 
  volume_type = "gp2"
  volume_size = "8"
  subnet_id = "${module.vpc.public_subnet_ids}"
  webapp_profile = "${module.webapp_profile.name}"
}

# ELB

module "elb" {
  source = "../modules/elb"
  name = "${var.app_name}"
  env = "${var.env}"
  security_groups = "${module.elb_sg.elb_id}"
  subnets = "${module.vpc.public_subnet_ids}"
  ec2_ids = "${module.webapp.instance_id}"
  instance_port = "80"
  lb_port = "80"
  health_check_target = "${var.health_check_target}"
}
