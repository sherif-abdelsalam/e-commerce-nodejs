#!/bin/bash

# Install Docker & AWS CLI
apt-get update -y
apt-get install -y docker.io awscli

# Start Docker
systemctl start docker
systemctl enable docker

# ECR Login
aws ecr get-login-password --region ${region} | \
  docker login --username AWS --password-stdin \
  $(echo ${image_name} | cut -d'/' -f1)

# Pull latest image
docker pull ${image_name}

# Fetch secrets from SSM
GMAIL=$(aws ssm get-parameter \
  --name "/nodejs-api/GMAIL" \
  --with-decryption \
  --region ${region} \
  --query 'Parameter.Value' \
  --output text)

GMAIL_PASSWORD=$(aws ssm get-parameter \
  --name "/nodejs-api/GMAIL_PASSWORD" \
  --with-decryption \
  --region ${region} \
  --query 'Parameter.Value' \
  --output text)

JWT_SECRET=$(aws ssm get-parameter \
  --name "/nodejs-api/JWT_SECRET" \
  --with-decryption \
  --region ${region} \
  --query 'Parameter.Value' \
  --output text)

MONGODB_URL=$(aws ssm get-parameter \
  --name "/nodejs-api/MONGODB_URL" \
  --with-decryption \
  --region ${region} \
  --query 'Parameter.Value' \
  --output text)

STRIPE_SECRET_KEY=$(aws ssm get-parameter \
  --name "/nodejs-api/STRIPE_SECRET_KEY" \
  --with-decryption \
  --region ${region} \
  --query 'Parameter.Value' \
  --output text)

# Run container
docker run -d \
  --name nodejs-api \
  --restart always \
  -p ${app_port}:${app_port} \
  -e PORT="${app_port}" \
  -e GMAIL="$GMAIL" \
  -e GMAIL_PASSWORD="$GMAIL_PASSWORD" \
  -e JWT_SECRET="$JWT_SECRET" \
  -e MONGODB_URL="$MONGODB_URL" \
  -e NODE_ENV="production" \
  -e STRIPE_SECRET_KEY="$STRIPE_SECRET_KEY" \
  ${image_name}