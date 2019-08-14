#!/bin/sh

BUCKET="apigw-s3-int-deployment-fjodor"
APISPECBUCKET="fjodors3apigatewayproxy"

# Deployment bucket
aws s3 mb s3://$BUCKET

# Build
sam build

# create apispec bucket
aws s3 mb s3://$APISPECBUCKET

# Upload apispec to bucket
aws s3 cp ./swagger.json s3://$APISPECBUCKET

# Uploads files to S3 bucket and creates CloudFormation template
sam package --template-file template.yaml --s3-bucket $BUCKET --output-template-file package.yaml

# Deploy
sam deploy --template-file package.yaml --stack-name apigw-s3-integration --capabilities CAPABILITY_IAM