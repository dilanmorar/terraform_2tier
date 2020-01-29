# set a provider
provider "aws" {
  region = "eu-west-1"
}

# create a vpc
resource "aws_vpc" "dm_vpc"{
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.Name
  }
}

# internet gateway
resource "aws_internet_gateway" "dm_internet_gateway"{
  vpc_id = aws_vpc.dm_vpc.id
  tags = {
   Name = var.Name
   }
}

# create a public subnet
resource "aws_subnet" "dm_public_subnet"{
  vpc_id = aws_vpc.dm_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = var.Name
  }
}

# nacl for public subnet
resource "aws_network_acl" "dm_public_nacl" {
  vpc_id = aws_vpc.dm_vpc.id
  subnet_ids = aws_subnet.dm_public_subnet.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.0.0.0/24"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.0.0/24"
    from_port  = 80
    to_port    = 80
  }
  tags = {
    Name = var.Name
  }
}

# create a private subnet
resource "aws_subnet" "dm_private_subnet"{
  vpc_id = aws_vpc.dm_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = var.Name
  }
}

# nacl for private subnet
resource "aws_network_acl" "dm_private_nacl" {
  vpc_id = aws_vpc.dm_vpc.id
  subnet_ids = aws_subnet.dm_private_subnet.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.0.0.0/24"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.0.0/24"
    from_port  = 80
    to_port    = 80
  }
  tags = {
    Name = var.Name
  }
}

# route table
resource "aws_route_table" "dm_route_table" {
  vpc_id = aws_vpc.dm_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dm_internet_gateway.id
  }
  tags = {
   Name = var.Name
  }
}

# route table association
resource "aws_route_table_association" "dm_association"{
  subnet_id = aws_subnet.dm_subnet.id
  route_table_id = aws_route_table.dm_route_table.id
}

# create a security group
resource "aws_security_group" "dm_security_group" {
  name        = "dm_security_dm"
  description = "Allow 80 TLS inbound traffic"
  vpc_id      = aws_vpc.dm_vpc.id

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.Name
  }
}

# launch an instance
# resource "aws_instance" "dm_instance"{
#   ami = var.ami-id
#   subnet_id = aws_subnet.dm_subnet.id
#   vpc_security_group_ids = [aws_security_group.dm_security_group.id]
#   instance_type = "t2.micro"
#   associate_public_ip_address = true
#   user_data = data.template_file.dm_init.rendered
#   tags = {
#     Name = "${var.Name}-instance"
#   }
# }
