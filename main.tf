provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "devops-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name : "${var.env_prefix}-vpc"
  }
}


module "myapp-subnet" {
  source            = "./modules/subnet"
  vpc_id            = aws_vpc.devops-vpc.id
  subnet_cidr_block = var.subnet_cidr_block
  avail_zone        = var.avail_zone
  env_prefix        = var.env_prefix

}

module "myapp-instance" {
  source              = "./modules/webserver"
  vpc_id              = aws_vpc.devops-vpc.id
  my_ip               = var.my_ip
  env_prefix          = var.env_prefix
  public_key_location = var.public_key_location
  instance_type       = var.instance_type
  avail_zone          = var.avail_zone
  image_name          = var.image_name
  subnet_id           = module.myapp-subnet.subnet.id

}
