#Define Buckets
resource "aws_s3_bucket" "exposedbucket" {
  bucket_prefix = "${var.victim_company}exposedbucket"
  tags = {
    Name        = "Exposed Bucket"
    env = "Dev"
    Owner = var.owner
  }
}

resource "aws_s3_bucket_public_access_block" "exposedbucket" {
  bucket                  = aws_s3_bucket.exposedbucket.id
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "exposedbucket" {
  bucket = aws_s3_bucket.exposedbucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "exposedbucket" {
  depends_on = [
	aws_s3_bucket_public_access_block.exposedbucket,
	aws_s3_bucket_ownership_controls.exposedbucket,
  ]

  bucket = aws_s3_bucket.exposedbucket.id
  acl    = "public-read"
}

