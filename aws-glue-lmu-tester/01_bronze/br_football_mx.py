import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# Script generated for node S3 bucket
S3bucket_node1 = glueContext.create_dynamic_frame.from_options(
    format_options={"quoteChar": '"', "withHeader": True, "separator": ","},
    connection_type="s3",
    format="csv",
    connection_options={"paths": ["s3://lmu-football"], "recurse": True},
    transformation_ctx="S3bucket_node1",
)

# Script generated for node ApplyMapping
ApplyMapping_node2 = ApplyMapping.apply(
    frame=S3bucket_node1,
    mappings=[
        ("Country", "string", "Country", "string"),
        ("League", "string", "League", "string"),
        ("Season", "string", "Season", "string"),
        ("Date", "string", "Date", "string"),
        ("Time", "string", "Time", "string"),
        ("Home", "string", "Home", "string"),
        ("Away", "string", "Away", "string"),
        ("HG", "string", "HG", "string"),
        ("AG", "string", "AG", "string"),
        ("Res", "string", "Res", "string"),
        ("PH", "string", "PH", "string"),
        ("PD", "string", "PD", "string"),
        ("PA", "string", "PA", "string"),
        ("MaxH", "string", "MaxH", "string"),
        ("MaxD", "string", "MaxD", "string"),
        ("MaxA", "string", "MaxA", "string"),
        ("AvgH", "string", "AvgH", "string"),
        ("AvgD", "string", "AvgD", "string"),
        ("AvgA", "string", "AvgA", "string"),
    ],
    transformation_ctx="ApplyMapping_node2",
)

# Script generated for node S3 bucket
S3bucket_node3 = glueContext.write_dynamic_frame.from_options(
    frame=ApplyMapping_node2,
    connection_type="s3",
    format="glueparquet",
    connection_options={"path": "s3://lmu-data", "partitionKeys": []},
    format_options={"compression": "snappy"},
    transformation_ctx="S3bucket_node3",
)

job.commit()
