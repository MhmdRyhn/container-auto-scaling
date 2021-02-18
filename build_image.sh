#!/bin/bash

set -x
set -e

image_name="container-auto-scaling"
#tag=$(date +"%y%m%d-%H%M")
tag="latest"
aws_profile="dev"  # Should be set using environment variable
aws_region="eu-west-1"  # Should be set using environment variable
account_id=$(aws sts --profile $aws_profile get-caller-identity | jq -r ".Account")

# Build docker image
docker build . -t "$account_id.dkr.ecr.$aws_region.amazonaws.com/$image_name:$tag"

# Login to AWS ECR
aws ecr get-login-password --profile $aws_profile --region $aws_region |
  docker login --username AWS --password-stdin "$account_id.dkr.ecr.$aws_region.amazonaws.com"
# Push the image to ECR
#docker push "$account_id.dkr.ecr.$aws_region.amazonaws.com/$image_name:$tag"
docker push "$account_id.dkr.ecr.$aws_region.amazonaws.com/$image_name:$tag"
