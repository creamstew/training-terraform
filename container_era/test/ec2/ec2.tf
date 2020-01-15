resource "aws_instance" "sandbox" {
    ami = "ami-785c491f"
    instance_type = "t2.micro"
    # remote_state を指定している
    subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_id
}
provider "aws" {
    region = "ap-northeast-1"
    profile = "sandbox"
}
# remote_state を設定し vpc という名前で参照できるようにしています 
data "terraform_remote_state" "vpc" {
    backend = "s3"

    config = {
    bucket = "training-terraform-sample"
    key    = "test/vpc/terraform.tfstate"
    region = "ap-northeast-1"
    }
}

terraform {
  backend "s3" {
    bucket = "training-terraform-sample"
    # キー名は vpc のものとかぶらないようにします
    key = "test/ec2/terraform.tfstate"
    region = "ap-northeast-1"
  }
}