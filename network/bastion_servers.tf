resource "aws_instance" "db_bastion" {
  key_name                    = "${aws_key_pair.key_pair.id}"
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "t2.nano"
  security_groups             = ["${aws_security_group.bastion_security_group.id}"]
  subnet_id                   = "${module.public_subnet.ids[0]}"
  tags                        = "${merge(
    var.default_tags,
    map(
      "Name", "${var.aws_env}-db-bastion"
    )
  )}"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.aws_env}-ttd-bastion"
  public_key = "${var.public_key}"
}

resource "aws_security_group" "bastion_security_group" {
  name        = "${var.aws_env}-bastion_sg"
  vpc_id      = "${module.vpc.id}"
  description = "${var.aws_env} DB bastion server"

  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "TCP"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  tags = "${merge(
      var.default_tags,
      map(
        "Name", "${var.environment}-bastion_sg"
      )
    )}"
}


resource "aws_eip" "bastion_eip" {
  instance = "${aws_instance.db_bastion.id}"
  vpc      = true
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}