variable "name" { default = "testwebapp" }
variable "env" { default = "dev" }
variable "instance_type" { default = "t2.micro" }
variable "ami_id" { default = "ami-a4c7edb2" }
variable "key_name" {}
variable "security_group_ids" {}
variable "subnet_id" {}
variable "count" {}
variable "volume_type" {}
variable "volume_size" {}
variable "webapp_profile" {}
variable "user_data" {}
