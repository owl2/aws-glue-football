import boto3
import requests
import json


client_ssm = boto3.client('ssm')
client_s3 = boto3.client('s3')

response = client_ssm.get_parameters(
    Names=[
        'marketstack',
    ]
)

api_key = response['Parameters'][0]['Value']

api_call = requests.get(f"""http://api.marketstack.com/v1/eod?access_key={api_key}&symbols=AAPL& date_from=2023-08-10&date_to=2023-08-20""")

response = api_call.json()

client_s3.put_object(
    Bucket='lmu-data',
    Key='bronze/marketstack/eod/Symbol=AAPL/from_2023_08_10_to_2023_08_20.json',
    Body=json.dumps(response, indent=2, default=str)
)



