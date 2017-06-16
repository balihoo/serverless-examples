from chalice import Chalice
import boto3
from boto3.dynamodb.conditions import Key, Attr
 
app = Chalice(app_name='svltest')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('serverless_test')


@app.route('/stuff/{id}', methods=['GET'], cors=True)
def index(id):
    return table.query(
        KeyConditionExpression=Key('id').eq(id)
    )
