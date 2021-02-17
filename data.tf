data "aws_vpc" "vpc_account" {
  id = "vpc-a3fda6db"
}

data "aws_subnet" "subnet_az1" {
  vpc_id            = data.aws_vpc.vpc_account.id
  availability_zone = "us-west-2a"
}

data "aws_subnet" "subnet_az2" {
  vpc_id            = data.aws_vpc.vpc_account.id
  availability_zone = "us-west-2b"
}

data "aws_iam_role" "ec2_role" {
  name = "role_ec2"
}