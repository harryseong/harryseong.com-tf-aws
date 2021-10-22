#!/bin/bash
set -ex
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | awk -F'"' '/"region"/ { print $4 }')
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
SPOT_REQ_ID=$(aws --region $REGION ec2 describe-instances --instance-ids "$INSTANCE_ID"  --query 'Reservations[0].Instances[0].SpotInstanceRequestId' --output text)

# Disable source/destination check on Spot EC2 Instance.
# See: https://github.com/pulumi/pulumi-aws/issues/959
aws --region $REGION ec2 modify-instance-attribute --instance-id "$INSTANCE_ID" --no-source-dest-check

# Add tags to Spot EC2 Instance.
# See: https://github.com/hashicorp/terraform/issues/3263#issuecomment-284387578
if [ "$SPOT_REQ_ID" != "None" ] ; then
  TAGS=$(aws --region $REGION ec2 describe-spot-instance-requests --spot-instance-request-ids "$SPOT_REQ_ID" --query 'SpotInstanceRequests[0].Tags')
  aws --region $REGION ec2 create-tags --resources "$INSTANCE_ID" --tags "$TAGS"
fi