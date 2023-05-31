resource "aws_subnet" "devops-subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
        Name: "${var.env_prefix}-subnet"
  }
}

resource "aws_route_table" "devops-route-table" {
  vpc_id = var.vpc_id

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.devops-internet-gateway.id
        }
  tags = {
        Name: "${var.env_prefix}-route_table"
        }
}

resource "aws_route_table_association" "devops-subnet-association" {
  subnet_id      = aws_subnet.devops-subnet.id
  route_table_id = aws_route_table.devops-route-table.id
}

resource "aws_internet_gateway" "devops-internet-gateway" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}