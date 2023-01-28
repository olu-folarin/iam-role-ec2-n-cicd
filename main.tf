resource "aws_s3_bucket" "folarins_bucket" {
  bucket = "simples-bucket"
}

# enable versioning
resource "aws_s3_bucket_acl" "v_acl" {
  bucket = aws_s3_bucket.folarins_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "v_1" {
  bucket = aws_s3_bucket.folarins_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# note that it's imperative that you create a security group for your ec2 instances for security
resource "aws_security_group" "http_server_sg" {
  name   = "http_server_sg"
  vpc_id = "vpc-06f8c47e55cbffe3d"
  #   ingress indicates where you wish to allow traffic from
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # cidr_blocks clearly state where you want to allow traffic from. ["0.0.0.0/0"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  #   also run an ingress for http which will run on port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # egress refers to where or what you can interact with over the internet
  # from_port and to_port show traffic from and to everywhere/anywhere while protocol=-1 means all protocols are allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "name" = "http_server_sg"
  }
}
# create and ec2 instance and link the role to it
resource "aws_instance" "ec2_instance" {
  ami           = "ami-0d09654d0a20d3ae2"
  instance_type = "t2.micro"

  # now link the role to the resource
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
}