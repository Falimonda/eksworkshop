#!/bin/bash

export DASHBOARD_VERSION="v2.0.0"

curl --silent --location -o dashboard.yaml https://raw.githubusercontent.com/kubernetes/dashboard/${DASHBOARD_VERSION}/aio/deploy/recommended.yaml

echo "- --enable-skip-login" >> dashboard.yaml

kubectl apply -f dashboard.yaml

# disable-filter disables request filtering which guards against XSRF attacks - dont disable for production
kubectl proxy --port=8080 --address=0.0.0.0 --disable-filter=true &

echo "Dashboard is available at http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):8080/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
