#!/bin/bash

aws eks get-token --cluster-name eksworkshop-eksctl | jq -r '.status.token'
