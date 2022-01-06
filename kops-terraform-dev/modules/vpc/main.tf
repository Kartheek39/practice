#
# AWS VPC setup
#
data "aws_availability_zones" "available" {}
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc["cidr"]}"
  enable_dns_hostnames = "${var.vpc["dns_hostnames"]}"
  enable_dns_support   = "${var.vpc["dns_support"]}"
  instance_tenancy     = "${var.vpc["tenancy"]}"

  tags = tomap({
    "Name"="${var.environment}_${var.cluster_name}_vpc",
    "kubernetes.io/cluster/${var.environment}_${var.cluster_name}"="shared"
  })
}

#
# AWS Subnets setup
#
locals{
  private_subnets_count = "${length(var.vpc.private_subnets)"
}
resource "aws_subnet" "public_subnets" {
  count                   = "${length(var.vpc.public_subnets)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))}"
  cidr_block              = "${var.vpc.public_subnets[count.index]}"
  map_public_ip_on_launch = true
  tags = tomap({
     "Name"="${var.environment}_${var.cluster_name}_public_${count.index}",
     "kubernetes.io/cluster/${var.environment}_${var.cluster_name}"="shared"
    })
}

resource "aws_subnet" "private_subnets" {
  count                   = "${length(var.vpc.private_subnets)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))}"
  cidr_block              = "${var.vpc.private_subnets[count.index]}"
  map_public_ip_on_launch = false
  tags = tomap({
     "Name"="${var.environment}_${var.cluster_name}_private_${count.index}",
     "kubernetes.io/cluster/${var.environment}_${var.cluster_name}"="shared"
    })
}


 RDS subnet

resource "aws_subnet" "private_rds_subnets" {
  count                   = "${length(var.vpc.rds_subnets)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))}"
  cidr_block              = "${var.vpc.rds_subnets[count.index]}"
  map_public_ip_on_launch = false
  tags = tomap({
     "Name"="${var.environment}_${var.cluster_name}_private_rds_${count.index}",
    })
}

resource "aws_db_subnet_group" "rds" {
  count      = "${length(var.vpc.rds_subnets) > 0 ? 1 : 0}"
  name       = "${var.environment}-rds-subnet-group"
  subnet_ids =  ["${aws_subnet.private_rds_subnets.*.id}"]
}

#
# AWS IGW setup
#
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "${var.environment}_${var.cluster_name}_igw"
  }
}

#
# AWS Nat Gateway setup
# Used for the private subnets
resource "aws_eip" "nat_gw" {
  count       = "${local.private_subnets_count> 0 ? 1 :0}"
  vpc         = true
  depends_on  = [aws_subnet.private_subnets]
}

resource "aws_nat_gateway" "nat_gw" {
  count         = "${local.private_subnets_count > 0 ? 1 : 0}"
  allocation_id = "${aws_eip.nat_gw.0.id}"
  subnet_id     = "${aws_subnet.public_subnets.0.id}"
  tags = {
    Name = "${var.environment}_${var.cluster_name}_nat"
  }
  depends_on = [aws_subnet.private_subnets,aws_subnet.public_subnets]
}