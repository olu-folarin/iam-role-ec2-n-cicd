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