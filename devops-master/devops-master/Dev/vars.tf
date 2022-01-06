# main creds for AWS connection
# variable "aws_access_key_id" {
#   description = "AWS access key"
# }

# variable "aws_secret_access_key" {
#   description = "AWS secret access key"
# }

variable "vpc_region" {
  description = "AWS region"
  default     = "us-east-1"
}

# VPC Config
variable "vpc_name" {
  description = "VPC for Dev"
  default     = "Kops-vpc"
}

variable "vpc_cidr_block" {
  description = "Dev VPC CIDR"
 default     = "172.16.0.0/16"
}

variable "igw_name" {
  default = "kops-IGW-Dev"
}

############Public Subnet 1
variable "subnet_public_1" {
  description = "Public subnet 1 for VPC"
  default     = "dev-pub-subnet-1"
}

variable "subnet_public_cidr_1" {
  description = "CIDR for public subnet 1"
  default     = "172.16.1.0/24"
}

variable "subnet_public_az_1" {
  description = "Availability zone for public subnet 1"
  default     = "us-east-1a"
}

variable "public_rt_name" {
  default = "RT-Dev-Public"
}

############Public Subnet 2
variable "subnet_public_2" {
  description = "Public subnet 2 for VPC"
  default     = "dev-pub-subnet-2"
}

variable "subnet_public_cidr_2" {
  description = "CIDR for public subnet 2"
  default     = "172.16.2.0/24"
}

variable "subnet_public_az_2" {
  description = "Availability zone for public subnet 2"
  default     = "us-east-1b"
}


############Private Subnet 1
variable "subnet_private_1" {
  description = "Private subnet 1 for VPC"
  default     = "dev-priv-subnet-1"
}

variable "subnet_private_cidr_1" {
  description = "CIDR for private subnet 1"
  default     = "172.16.3.0/24"
}

variable "subnet_private_az_1" {
  description = "Availability zone for private subnet 1"
  default     = "us-east-1a"
}

############Private Subnet 2
variable "subnet_private_2" {
  description = "Private subnet for VPC"
  default     = "dev-priv-subnet-2"
}

variable "subnet_private_cidr_2" {
  description = "CIDR for private subnet 2"
  default     = "172.16.4.0/24"
}

variable "subnet_private_az_2" {
  description = "Availability zone for private subnet"
  default     = "us-east-1b"
}

variable "private_rt_name" {
  default = "RT-Dev-Private"
}

############Private Subnet 3

variable "subnet_private_3" {
  description = "Private subnet for VPC"
  default     = "dev-priv-subnet-3"
}

variable "subnet_private_cidr_3" {
  description = "CIDR for private subnet 3"
  default     = "172.16.5.0/24"
}

variable "subnet_private_az_3" {
  description = "Availability zone for private subnet"
  default     = "us-east-1c"
}

############Private Subnet 4

variable "subnet_private_4" {
  description = "Private subnet for VPC"
  default     = "dev-priv-subnet-4"
}

variable "subnet_private_cidr_4" {
  description = "CIDR for private subnet 3"
  default     = "172.16.6.0/24"
}

variable "subnet_private_az_4" {
  description = "Availability zone for private subnet"
  default     = "us-east-1d"
}

variable "cluster_name" {
  description = "Availability zone for private subnet"
  default     = "sample-kops"
}

variable "dns_zone" {
  description = "Availability zone for private subnet"
  default     = "jainankur229.xyz"
}

variable "state_bucket" {
  description = "Availability zone for private subnet"
  default     = "cluster-kops"
}
variable "min_worker_nodes" {
  description = "Availability zone for private subnet"
  default     = "1"
}

variable "max_worker_nodes" {
  description = "Availability zone for private subnet"
  default     = "3"
}

variable "worker_node_type" {
  description = "Availability zone for private subnet"
  default     = "t3.large"
}

variable "master_node_type" {
  description = "Availability zone for private subnet"
  default     = "t3.medium"
}

variable "kubernetes_version" {
  description = "Availability zone for private subnet"
  default     = "1.20.7"
}