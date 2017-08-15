# VPC

resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  tags { 
    Name = "${var.env}-vpc"
    Environment = "${var.env}"
  }   
}

# Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags { Name = "${var.env}-gw" }
}

# Public Subnets

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  count = "${length(split(",", var.public_cidrs))}"
  cidr_block = "${element(split(",", var.public_cidrs), count.index)}"
  availability_zone = "${element(split(",", var.availability_zones), count.index)}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
  tags { Name = "${var.env}-pub-${element(split(",", var.availability_zones), count.index)}" }
}

# Route Table

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags { Name = "${var.env}-public" }
}

resource "aws_route_table_association" "public" {
  count = "${length(split(",", var.public_cidrs))}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

# Private Subnets

resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  count = "${length(split(",", var.private_cidrs))}"
  cidr_block = "${element(split(",", var.private_cidrs), count.index)}"
  availability_zone = "${element(split(",", var.availability_zones), count.index)}"
  map_public_ip_on_launch = false
}

# Route Table

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags { Name = "${var.env}-private" }
}

resource "aws_route_table_association" "private" {
  count = "${length(split(",", var.private_cidrs))}"
  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}

output "vpc_id" {value = "${aws_vpc.vpc.id}"}
output "private_subnet_ids" {value = "${join(",", aws_subnet.private.*.id)}"}
output "public_subnet_ids" {value = "${join(",", aws_subnet.public.*.id)}"}
output "availability_zones" {value = "${var.availability_zones}"}
