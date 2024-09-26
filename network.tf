/*
Network

#Componentes de la red
- VPC: 10.0.0.0/16
- Subnet 1: 10.0.10.0/24
- Subnet 2: 10.0.20.0/24
- Subnet 3: 10.0.30.0/24

- Internet Gateway
- Tabla de enrutamiento
- Asociacion de tabla de enrutamiento
*/

#Creacion de una red
resource "aws_vpc" "net_ue_reg" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "tag_net_ue_vpc"
  }
}

resource "aws_vpc" "net_eur_reg" {
  provider   = aws.europe # le indica a terraform el provider a donde tiene que desplegar esos recursos
  cidr_block = "172.16.0.0/16"
}

#Creacion de una subnet en una determinada vpc
resource "aws_subnet" "subnet_ue_1" {
  vpc_id            = aws_vpc.net_ue_reg.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.10.0/24"

  tags = {
    Name = "tag_subnet_ue_1"
  }
}
resource "aws_subnet" "subnet_ue_2" {
  vpc_id            = aws_vpc.net_ue_reg.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.20.0/24"

  tags = {
    Name = "tag_subnet_ue_2"
  }
}
resource "aws_subnet" "subnet_ue_3" {
  vpc_id            = aws_vpc.net_ue_reg.id
  availability_zone = "us-east-1c"
  cidr_block        = "10.0.30.0/24"

  tags = {
    Name = "tag_subnet_ue_3"
  }
}


# Creacion de una internet gateway
resource "aws_internet_gateway" "igw_net_ue" {
  vpc_id = aws_vpc.net_ue_reg.id
  tags = {
    Name = "tag_net_ue_igw"
  }
}

# Creacion de una tabla de enrutamiento 
resource "aws_route_table" "rt_igw_net_ue" {
  vpc_id = aws_vpc.net_ue_reg.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_net_ue.id
  }

  tags = {
    Name = "tag_rt_igw_net_ue"
  }
}

# Asociacion de la tabla de enrutamiento a cada subnet
# una subnet solo puede estar asociada a una sola tabla de enrutamiento 

resource "aws_route_table_association" "subnet_ue_1" {
  subnet_id      = aws_subnet.subnet_ue_1.id
  route_table_id = aws_route_table.rt_igw_net_ue.id
}
resource "aws_route_table_association" "subnet_ue_2" {
  subnet_id      = aws_subnet.subnet_ue_2.id
  route_table_id = aws_route_table.rt_igw_net_ue.id
}
resource "aws_route_table_association" "subnet_ue_3" {
  subnet_id      = aws_subnet.subnet_ue_3.id
  route_table_id = aws_route_table.rt_igw_net_ue.id
}
