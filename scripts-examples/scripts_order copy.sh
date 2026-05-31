#!/bin/bash

# Create ECR only
echo "--------------------Creating ECR--------------------"
cd terraform
terraform init
terraform apply -auto-approve -target=aws_ecr_repository.app
cd ..


# Store secrets in SSM
./ssm.example.sh


# Build, push image and create rest of infra
./build.example.sh


# Get ALB URL
echo "--------------------ALB URL--------------------"
cd terraform
terraform output alb_dns
cd ..