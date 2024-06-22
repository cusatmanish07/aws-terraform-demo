
# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.env}-main"
  }
}

# Create Public Subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.env}-pub"
  }
}

# Create Private Subnet
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.env}-priv"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-igw"
  }
}

# Create Public Route Table
resource "aws_route_table" "pub-main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.env}-pub-rt"
  }
}

# Associate Public Subnet to Public Route Table
resource "aws_route_table_association" "public-association" {
  route_table_id = aws_route_table.pub-main.id
  subnet_id = aws_subnet.public.id
}

# Create Elastic IP for NAT
resource "aws_eip" "nat-main" {
  domain   = "vpc"
}

# Create Nat Gateway
resource "aws_nat_gateway" "main-ngw" {
  allocation_id = aws_eip.nat-main.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "${var.env}-natgw"
  }
}

# Create Private Route Table

resource "aws_route_table" "pri-main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main-ngw.id
  }
  tags = {
    Name = "${var.env}-priv-rt"
  }
}

# Associate Private Route table to Private Subnet
resource "aws_route_table_association" "pri-association" {
  route_table_id = aws_route_table.pri-main.id
  subnet_id = aws_subnet.private.id
}

