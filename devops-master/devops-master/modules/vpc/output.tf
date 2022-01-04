output "name" {
  value = "${var.vpc_name}"
}

output "id" {
  value = "${aws_vpc.primary_vpc.id}"
}

output "region" {
  value = "${var.vpc_region}"
}

output "nat_eip" {
  value = "${aws_eip.nat_eip.public_ip}"
}

output  "gw"  {
  value = "${aws_internet_gateway.gw.id}"
}

output "eip_id" {
  value = "${aws_eip.nat_eip.id}"
}

