#!/bin/bash

## AZS export in env doesnt work because bash doesn't support arrays in env so we need to set it again here
AZS=($(aws ec2 describe-availability-zones --query 'AvailabilityZones[].ZoneName' --output text --region $AWS_REGION))

if [[ ! $(echo $AWS_REGION) ]];then
	echo "No AWS_REGION set. Exiting"
	exit
fi

if [[ ! $(echo $MASTER_ARN) ]];then
	echo "No MASTER_ARN set. Exiting"
	exit
fi

if [[ ! $(echo ${AZS[@]}) ]];then
	echo "AZS set. Exiting"
	exit
fi

rm -i eksworkshop.yaml

cat << EOF > eksworkshop.yaml
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: eksworkshop-eksctl
  region: ${AWS_REGION}
  version: "1.19"

availabilityZones: ["${AZS[0]}", "${AZS[1]}", "${AZS[2]}"]

managedNodeGroups:
- name: nodegroup
  desiredCapacity: 3
  instanceType: t3.small
  ssh:
    enableSsm: true

# To enable all of the control plane logs, uncomment below:
# cloudWatch:
#  clusterLogging:
#    enableTypes: ["*"]

secretsEncryption:
  keyARN: ${MASTER_ARN}
EOF
