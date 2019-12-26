resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = true

  tags = "${merge(
    var.tags,
    map(
      "Name", "${var.vpc_name}"
    )
  )}"
}

resource "aws_internet_gateway" "vpc" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${var.tags}"
}
