#!/bin/bash

ROLEARN=arn:aws:iam::949908042366:role/eksworkshop-admin

eksctl create iamidentitymapping --cluster eksworkshop-eksctl --arn ${ROLEARN} --group system:masters --username admin

