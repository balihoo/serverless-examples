import boto3
from boto3.dynamodb.conditions import Key, Attr

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('serverless_test')


def lambda_handler(event):
    if event.get('id'):
        return table.query(
            KeyConditionExpression=Key('id').eq(event.get('id'))
        )
    else:
        raise Exception("Parameter 'id' required")
