## Bronze job 
######

resource "aws_glue_job" "br_football_mx" {
  name              = "br_football_mx"
  role_arn          = aws_iam_role.lmu_glue.arn
  glue_version      = "4.0"

  worker_type       = "Standard"
  number_of_workers = 2

  command {
    script_location = "s3://${aws_s3_bucket.aws_glue_lmu_tester.bucket}/scripts/bronze/br_football_mx.py"
    python_version  = "3"
  }

  default_arguments = {
    "--enable-metrics"                   = "true"
    "--enable-spark-ui"                  = "true"
    "--spark-event-logs-path3"           = "s3://aws-glue-assets-471379067324-us-east-2/sparkHistoryLogs/"
    "--enable-job-insights"              = "true"
    "--enable-glue-datacatalog"          = "true"
    "--enable-continuous-cloudwatch-log" = "true"
    "--job-bookmark-option"              = "job-bookmark-disable"
    "--job-language"                     = "python"
    "--TempDir"                          = "s3://aws-glue-assets-471379067324-us-east-2/temporary/"

    # "--spark-event-logs-path"            = aws_cloudwatch_log_group.aws_glue_lmu_tester.name
    # "--enable-continuous-cloudwatch-log" = "true"
  }

  depends_on = [ 
    aws_s3_object.br_football_mx
   ]
}


resource "aws_glue_job" "br_api_jsonplaceholder" {
  name              = "br_api_jsonplaceholder"
  role_arn          = aws_iam_role.lmu_glue.arn

  max_capacity = "0.0625"

  command {
    script_location = "s3://${aws_s3_bucket.aws_glue_lmu_tester.bucket}/scripts/bronze/br_api_jsonplaceholder.py"
    python_version  = "3.9"
  }

  default_arguments = {
    "--enable-job-insights"              = "true"
    "--job-language"                     = "python"
    "--TempDir"                          = "s3://aws-glue-assets-471379067324-us-east-2/temporary/"

    # "--spark-event-logs-path"            = aws_cloudwatch_log_group.aws_glue_lmu_tester.name
    # "--enable-continuous-cloudwatch-log" = "true"
  }

  depends_on = [ 
    aws_s3_object.br_football_mx
   ]
}


## Silver job 
######


## Gold job 
######