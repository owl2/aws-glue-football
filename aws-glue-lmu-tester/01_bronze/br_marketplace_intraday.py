import boto3
import requests


client_ssm = boto3.client('ssm')

response = client_ssm.get_parameters(
    Names=[
        'marketstack',
    ]
)

api_keys = response['Parameters'][0]['Value']

# api_result = requests.get('https://api.marketstack.com/v1/tickers/aapl/eod', params)

# api_response = api_result.json()