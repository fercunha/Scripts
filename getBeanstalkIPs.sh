#!/bin/bash
# Script para verificar os IPs das instâncias de um ambiente Elastic Beanstalk da AWS.
#

IDS=$(aws elasticbeanstalk describe-environment-resources --environment-id e-muqbipfvq5 --profile netwifi --region us-east-1 | grep Id | cut -d\" -f4)

for ID in $IDS
do 
	#echo "IDS é : ${IDS}"
	#echo "ID é : ${ID}"
	aws ec2 describe-instances --instance-ids $ID --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text --profile netwifi --region us-east-1
done