#!/bin/bash

# Variables
region="REGION"
aws_id="AWS_ACCOUNT_ID"
repo_name="REPOSITORY_NAME"
app="APP_NAME"
image_name="$aws_id.dkr.ecr.$region.amazonaws.com/$repo_name:latest"

# Remove Docker image locally
echo "--------------------Remove Local Docker Image--------------------"
docker rmi -f $image_name || true

# Delete all images in ECR
echo "--------------------Clear ECR Images--------------------"


# # Delete SSM parameters
echo "--------------------Delete SSM Parameters--------------------"


# Destroy Terraform infra
echo "--------------------Destroying Infra--------------------"
cd terraform
terraform destroy -auto-approve
cd ..

echo "--------------------Done--------------------"
echo "All resources destroyed"