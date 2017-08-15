variable env { default = "prod" }
variable app_name { default = "webapp" }
variable vpc_cidr { default = "10.30.0.0/16" }
variable public_cidrs { default = "10.30.1.0/24,10.30.3.0/24" }
variable private_cidrs { default = "10.30.2.0/24,10.30.4.0/24" }
variable dbname { default = "testdb" }
variable role { default = "webapp" }
variable instance_count { default = "2" }
variable user_data { default = "#!/bin/bash\nsudo yum update -y\nsudo yum install -y awslogs\nsudo service awslogs start\n sudo chkconfig awslogs on" }
variable health_check_target { default = "HTTP:80/signin/?next=/" }
variable instance_type { default = "t2.micro" }
variable min_size { default = "2" }
variable max_size { default = "2" }
