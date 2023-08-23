from awsglue.context import GlueContext
import boto3
import json
import requests 


# Initializes S3 client
s3 = boto3.client('s3')

response = requests.get('https://jsonplaceholder.typicode.com/users/').json()

s3.put_object(
    Bucket='lmu-data', 
    Key='bronze/jsonplaceholder/data.json',
    Body=json.dumps(response, indent=2, default=str)
)
