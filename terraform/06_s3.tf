### Glue Script

resource "aws_s3_bucket" "aws_glue_lmu_tester" {
  bucket = "aws-glue-lmu-tester"
  force_destroy = true

  tags = {
    Name        = "aws_glue_lmu_tester"
    Environment = "PoC"
  }
}

resource "aws_s3_object" "br_football_mx" {
  bucket = aws_s3_bucket.aws_glue_lmu_tester.bucket
  key    = "scripts/bronze/br_football_mx.py"
  source = local.br_football_mx
  force_destroy = true

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(local.br_football_mx)
}