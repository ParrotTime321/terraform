variable "vcp_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_ciders" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"]
}
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vcp_cidr
  tags = {
    Name = "vpc-${var.env}" 
  }
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main_vpc.id
}

data "aws_availability_zones" "available" {
}
resource "aws_subnet" "public" {
  count = length(var.public_subnet_ciders)
  cidr_block = element(var.public_subnet_ciders, count.index)
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
}


resource "aws_route_table" "public" {
  count = length(var.public_subnet_ciders)
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.env}-public-${count.index + 1}"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_ciders)
  route_table_id = aws_route_table.public[count.index].id
  subnet_id = element(aws_subnet.public[*].id, count.index)
}