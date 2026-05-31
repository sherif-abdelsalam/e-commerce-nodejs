#!/bin/bash

# Variables
region="REGION"
app="APP_NAME"

# Secrets
PORT="PORT_NUMBER"  
MONGODB_URL="MONGODB_CONNECTION_STRING"
GMAIL="GMAIL_ADDRESS"
GMAIL_PASSWORD="GMAIL_PASSWORD"
JWT_SECRET="JWT_SECRET"
STRIPE_SECRET_KEY="STRIPE_SECRET_KEY"

echo "--------------------Storing Secrets in SSM--------------------"

aws ssm put-parameter \
  --name "/$app/MONGODB_URL" \
  --value "$MONGODB_URL" \
  --type SecureString \
  --region $region \
  --overwrite

aws ssm put-parameter \
  --name "/$app/GMAIL" \
  --value "$GMAIL" \
  --type SecureString \
  --region $region \
  --overwrite

aws ssm put-parameter \
  --name "/$app/GMAIL_PASSWORD" \
  --value "$GMAIL_PASSWORD" \
  --type SecureString \
  --region $region \
  --overwrite

aws ssm put-parameter \
  --name "/$app/JWT_SECRET" \
  --value "$JWT_SECRET" \
  --type SecureString \
  --region $region \
  --overwrite

aws ssm put-parameter \
  --name "/$app/STRIPE_SECRET_KEY" \
  --value "$STRIPE_SECRET_KEY" \
  --type SecureString \
  --region $region \
  --overwrite

aws ssm put-parameter \
  --name "/$app/PORT" \
  --value "$PORT" \
  --type String \
  --region $region \
  --overwrite  

echo "--------------------Done--------------------"
echo "Secrets stored:"
aws ssm get-parameters-by-path \
  --path "/$app/" \
  --region $region \
  --query 'Parameters[*].Name' \
  --output table