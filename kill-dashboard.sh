#!/bin/bash


DASHBOARD_VERSION=v2.0.0

sudo pkill -9 'kubectl'

kubectl delete -f dashboard.yaml
#https://raw.githubusercontent.com/kubernetes/dashboard/${DASHBOARD_VERSION}/aio/deploy/recommended.yaml
