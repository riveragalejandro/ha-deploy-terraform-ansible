variable "name" {
	default = "testssh"
}

variable "env" {
	default = "dev"
}

variable "ingress_cidr_blocks" {
	default = "0.0.0.0/0"
}

variable "egress_cidr_blocks" {
	default = "0.0.0.0/0"
}

variable "vpc_id" {
}
