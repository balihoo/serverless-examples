import boto3
from boto3.dynamodb.conditions import Key, Attr

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('serverless_test')


def lambda_handler(event):
    id = event.get('id')
    
    if id:
        return table.query(
            KeyConditionExpression=Key('id').eq(id)
        )
    else:
        raise Exception("Parameter 'id' required")
