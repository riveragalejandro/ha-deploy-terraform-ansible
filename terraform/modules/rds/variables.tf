variable "name" {
  default = "testrds"
}

variable "env" {
  default = "dev"
}

variable "subnet_ids" {
}

variable "security_group_ids" {
}

variable "storage" {
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "db_name" {
}

variable "username" {
	default = "admindb"
}

variable "password" {
	default = "mysupersecretpassword"
}

variable "skip_final_snapshot" {
	default = "false"
}
