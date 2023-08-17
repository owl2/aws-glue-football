resource "aws_cloudwatch_log_group" "aws_glue_lmu_tester" {
  name              = "/aws-glue/lmu-tester"
  retention_in_days = 14
}
