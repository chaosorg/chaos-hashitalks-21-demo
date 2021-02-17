data "aws_vpc" "vpc_account" {
  id = "vpc-a3fda6db"
}

data "aws_subnet" "subnet_az1" {
  vpc_id            = data.aws_vpc.vpc_account.id
  availability_zone = "us-west-2a"
}