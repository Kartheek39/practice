resource "aws_nat_gateway" "nat" {
    allocation_id = "${var.allocation_id}"
    subnet_id     = "${var.subnet_id}"
    # depends_on = ["aws_internet_gateway.gw"]
}