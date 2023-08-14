## Bronze job 
######

resource "aws_glue_job" "br_football_mx" {
  name     = "br_football_mx"
  role_arn = aws_iam_role.lmu_glue.arn

  command {
    script_location = "s3://${aws_s3_bucket.aws_glue_lmu_tester.bucket}/scripts/bronze/br_football_mx.py"
  }

  default_arguments = {
    "--spark-event-logs-path"          = aws_cloudwatch_log_group.aws_glue_lmu_tester.name
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-metrics"                   = ""
  }

  depends_on = [ 
    aws_s3_object.br_football_mx
   ]
}


## Silver job 
######


## Gold job 
######