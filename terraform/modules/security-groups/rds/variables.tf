variable "name" {
	default = "testrds"
}

variable "env" {
	default = "dev"
}

variable "security_group_ids" {
}

variable "egress_cidr_blocks" {
	default = "0.0.0.0/0"
}

variable "vpc_id" {
}
