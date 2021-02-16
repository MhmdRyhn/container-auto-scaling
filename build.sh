#!/bin/bash

set -x
set -e

aws_profile="dev"
account_id=$(aws sts --profile $aws_profile get-caller-identity | jq -r ".Account")
aws_region="eu-west-1"

tag=$(date +"%y%m%d-%H%M")

# Build docker image
docker build . -t "$account_id.dkr.ecr.$aws_region.amazonaws.com/container-auto-scaling:$tag"
# Login to AWS ECR
aws ecr get-login-password --profile $aws_profile --region $aws_region |
  docker login --username AWS --password-stdin "$account_id.dkr.ecr.eu-west-1.amazonaws.com"
# Push the image to ECR
#docker push "$account_id.dkr.ecr.$aws_region.amazonaws.com/container-auto-scaling:$tag"
docker push "$account_id.dkr.ecr.$aws_region.amazonaws.com/container-auto-scaling"
