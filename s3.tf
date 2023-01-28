resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "my-tf-deploy-state-bucket"
}

terraform {
  backend "s3" {
    bucket = "my-tf-deploy-state-bucket"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}
