# Provider
provider "aws" {
  # access_key = "${var.aws_access_key_id}"
  # secret_key = "${var.aws_secret_access_key}"
  profile    = "default"
  region     = "${var.vpc_region}"
}

module "vpc" {
  source = "../modules/vpc"

  vpc_region     = "${var.vpc_region}"
  vpc_name       = "${var.vpc_name}"
  vpc_cidr_block = "${var.vpc_cidr_block}"
  igw_name       = "${var.igw_name}"
}

module "subnet_public_1" {
  source = "../modules/subnet_public"

  vpc_id      = "${module.vpc.id}"
  vpc_region  = "${module.vpc.region}"
  subnet_name = "${var.subnet_public_1}"
  subnet_cidr = "${var.subnet_public_cidr_1}"
  subnet_az   = "${var.subnet_public_az_1}"
  #route_table_id = "${module.public_route_table.public_rt_id}"
}

module "subnet_public_2" {
  source = "../modules/subnet_public"

  vpc_id      = "${module.vpc.id}"
  vpc_region  = "${module.vpc.region}"
  subnet_name = "${var.subnet_public_2}"
  subnet_cidr = "${var.subnet_public_cidr_2}"
  subnet_az   = "${var.subnet_public_az_2}"
  #route_table_id = "${module.public_route_table.public_rt_id}"
}

module "public_route_table" {
  source = "../modules/rt_public"

  vpc_id      = "${module.vpc.id}"
  #subnet_id = "${module.subnet_public_1.id}"
  public_rt_name ="${var.public_rt_name}"
}

module "public_route_association_1" {
  source = "../modules/rt_association"

  subnet_id      = "${module.subnet_public_1.id}"
  route_table_id = "${module.public_route_table.public_rt_id}"
  
}

module "public_route_association_2" {
  source = "../modules/rt_association"

  subnet_id      = "${module.subnet_public_2.id}"
  route_table_id = "${module.public_route_table.public_rt_id}"
  
}

module "route_to_igw" {
  source = "../modules/routes"

  rt_id         = "${module.public_route_table.public_rt_id}"
  #destination_cidr_block = "0.0.0.0/0"
  gw_id = "${module.vpc.gw}"
}

module "subnet_private_1" {
  source = "../modules/subnet_private"

  vpc_id      = "${module.vpc.id}"
  vpc_region  = "${module.vpc.region}"
  subnet_name = "${var.subnet_private_1}"
  subnet_cidr = "${var.subnet_private_cidr_1}"
  subnet_az   = "${var.subnet_private_az_1}"
# route_table_id = "${module.private_route_table.private_rt_id}"
}

module "subnet_private_2" {
  source = "../modules/subnet_private"

  vpc_id      = "${module.vpc.id}"
  vpc_region  = "${module.vpc.region}"
  subnet_name = "${var.subnet_private_2}"
  subnet_cidr = "${var.subnet_private_cidr_2}"
  subnet_az   = "${var.subnet_private_az_2}"
  #route_table_id = "${module.private_route_table.private_rt_id}"
}

module "subnet_private_3" {
  source = "../modules/subnet_private"

  vpc_id      = "${module.vpc.id}"
  vpc_region  = "${module.vpc.region}"
  subnet_name = "${var.subnet_private_3}"
  subnet_cidr = "${var.subnet_private_cidr_3}"
  subnet_az   = "${var.subnet_private_az_3}"
  # route_table_id = "${module.private_route_table.private_rt_id}"
}

module "subnet_private_4" {
  source = "../modules/subnet_private"

  vpc_id      = "${module.vpc.id}"
  vpc_region  = "${module.vpc.region}"
  subnet_name = "${var.subnet_private_4}"
  subnet_cidr = "${var.subnet_private_cidr_4}"
  subnet_az   = "${var.subnet_private_az_4}"
  # route_table_id = "${module.private_route_table.private_rt_id}"
}

module "natgw" {
   source = "../modules/NAT"

   allocation_id = "${module.vpc.eip_id}"
   subnet_id     = "${module.subnet_public_1.id}"
#   #depends_on = ["aws_internet_gateway.gw"]
 }

module "route_to_ngw" {
  source = "../modules/routes"

  rt_id         = "${module.private_route_table.private_rt_id}"
  #destination_cidr_block = "0.0.0.0/0"
  gw_id = "${module.natgw.natgw_id}"
}

module "private_route_table" {
  source = "../modules/rt_private"

  vpc_id      = "${module.vpc.id}"
  #subnet_id = "${module.subnet_private_1.id}"
  private_rt_name ="${var.private_rt_name}"
}

#module "private_route_association_1" {
#  source = "../modules/rt_association"
#
#  subnet_id      = "${module.subnet_private_1.id}"
#  route_table_id = "${module.private_route_table.private_rt_id}"
#
#}
#
#module "private_route_association_2" {
#  source = "../modules/rt_association"
#
#  subnet_id      = "${module.subnet_private_2.id}"
#  route_table_id = "${module.private_route_table.private_rt_id}"
#
#}

module "kubernetes" {
  source          = "../modules/kubernetes"
#  vpc             = "${module.vpc.id}"
#  public_subnets  = "${module.subnet_public}"
#  private_subnets = "${module.subnet_private}"
#  kops_cluster    = "${var.cluster_name}"
  vpc_region  = "${var.vpc_region}"
  state_bucket = "${var.state_bucket}"
  #vpc_region   = "${var.vpc_region}"
  cluster_name  = "${var.cluster_name}"
  dns_zone      = "${var.dns_zone}"
  min_worker_nodes = "${var.min_worker_nodes}"
  max_worker_nodes = "${var.max_worker_nodes}"
  master_node_type = "${var.master_node_type}"
  vpc_cidr_block   = "${var.vpc_cidr_block}"
  worker_node_type = "${var.worker_node_type}"
  kubernetes_version = "${var.kubernetes_version}"
  node_image = "${var.node_image}"
  subnet_public_1 = "${var.subnet_public_1}"
  subnet_public_az_1 = "${var.subnet_public_az_1}"
  subnet_public_cidr_1 = "${var.subnet_public_cidr_1}"
}


