# here i create an iam role with administrative access to the ec2 instances
resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = aws_iam_role.folarin_ec2_role.id
  # now grant full access to ec2 using intrapolations and fie functions
  policy = file("iam-policy.json")
}

resource "aws_iam_role" "folarin_ec2_role" {
  name               = "folarin_ec2_role"
  assume_role_policy = file("iam-role.json")
}

# an instance profile to connect to the ec2 instance(s
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "folarin_ec2_profile"
  role = aws_iam_role.folarin_ec2_role.name
}

# create and ec2 instance and link the role to it
resource "aws_instance" "ec2_instance" {
  ami           = "ami-0d09654d0a20d3ae2"
  instance_type = "t2.micro"

  # now link the role to the resource
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
}