#!/bin/bash

region="REGION"
aws_id="AWS_ACCOUNT_ID"
repo_name="REPOSITORY_NAME"
app_name="APP_NAME"
image_name="$aws_id.dkr.ecr.$region.amazonaws.com/$repo_name:latest"
asg_name="ASG_NAME"


# Remove previous docker image
echo "--------------------Remove Previous Build--------------------"
docker rmi -f $image_name || true

# Build new docker image
echo "--------------------Build New Image--------------------"
docker build -t $image_name .


echo "--------------------Login to ECR--------------------"
aws ecr get-login-password --region $region | \
  docker login --username AWS --password-stdin \
  $aws_id.dkr.ecr.$region.amazonaws.com

echo "--------------------Push Image--------------------"
docker push $image_name



#  Create rest of infra
echo "--------------------Creating Infra--------------------"
cd terraform
terraform apply -auto-approve
cd ..

echo "--------------------Trigger Instance Refresh--------------------"
aws autoscaling start-instance-refresh \
  --auto-scaling-group-name $asg_name \
  --region $region \
  --preferences '{"MinHealthyPercentage": 50, "InstanceWarmup": 60}'
