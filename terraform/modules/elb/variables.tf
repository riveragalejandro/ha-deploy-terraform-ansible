variable "name" {
	default = "testelb"
}

variable "env" {
	default = "dev"
}

variable "security_groups" {
}

variable "lb_port" {
	default = 80
}

variable "instance_port" {
	default = 80
}

variable "subnets" {
}

variable "ec2_ids" {
}

variable "health_check_target"{
}
