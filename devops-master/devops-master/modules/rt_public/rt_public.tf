resource "aws_route_table" "RT-Dev-Public" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "${var.public_rt_name}"
  }
}

# Associate the routing table to private subnet
# resource "aws_route_table_association" "rt_assn" {
#   subnet_id      = "${var.subnet_id}"
#   route_table_id = "${aws_route_table.RT-Dev-Public.id}"
# }
