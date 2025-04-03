# Create a VPC
resource "aws_vpc" "terraform-vpc-docker" {
  cidr_block = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "terraform-vpc-docker"
    env = "Dev"
    team = "docker"
  }
}

# Internet gateway
resource "aws_internet_gateway" "gw2" {
  vpc_id = aws_vpc.terraform-vpc-docker.id

  tags = {
    Name = "terrafrom-vpc-docker"
    env = "Dev"
    team = "docker"
  }
}

#subnet public 
resource "aws_subnet" "pub-sub1" {
  vpc_id     = aws_vpc.terraform-vpc-docker.id
  cidr_block = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-useast-1a"
  }
}

resource "aws_subnet" "pub-sub2" {
  vpc_id     = aws_vpc.terraform-vpc-docker.id
  cidr_block = "192.168.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-useast-1b"
  }
}

#subnet private 
resource "aws_subnet" "priv-sub2" {
  vpc_id     = aws_vpc.terraform-vpc-docker.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "priv-useast-1a"
  }
}
resource "aws_subnet" "priv-sub1" {
  vpc_id     = aws_vpc.terraform-vpc-docker.id
  cidr_block = "192.168.4.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "priv-useast-1b"
  }
}

#private route table 
resource "aws_route_table" "rtpriv1" {
    vpc_id = aws_vpc.terraform-vpc-docker.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw2.id
    }
  tags = { 
    Name = "private-routetable"
  }
}

#public route table 
resource "aws_route_table" "rtpub1" {
    vpc_id = aws_vpc.terraform-vpc-docker.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw2.id
    }
  tags = { 
    Name = "pub-routetable"
  }
}

#private route table association 
resource "aws_route_table_association" "privrta1" {
  subnet_id = aws_subnet.priv-sub1.id
  route_table_id = aws_route_table.rtpriv1.id
}
resource "aws_route_table_association" "privrta2" {
  subnet_id = aws_subnet.priv-sub2.id
  route_table_id = aws_route_table.rtpriv1.id
}
#public route table association 
resource "aws_route_table_association" "pubrta1" {
  subnet_id = aws_subnet.pub-sub1.id
  route_table_id = aws_route_table.rtpub1.id
}
resource "aws_route_table_association" "pubrta2" {
  subnet_id = aws_subnet.pub-sub2.id
  route_table_id = aws_route_table.rtpub1.id
}