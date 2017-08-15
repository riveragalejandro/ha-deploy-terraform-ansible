variable "env" {
	default = "dev"
}

variable "vpc_cidr" {
	default = "10.10.0.0/16"
}

variable "public_cidrs" {
	default = "10.10.1.0/24,10.10.3.0/24"
}

variable "private_cidrs" {
	default = "10.10.2.0/24,10.10.4.0/24"
}

variable "availability_zones" {
	default = "us-east-1a,us-east-1b"
}

variable "map_public_ip_on_launch" {
	default = true
}
