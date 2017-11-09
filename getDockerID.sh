#!/bin/bash
# Script para verificar os IPs das instâncias de um ambiente Elastic Beanstalk da AWS.
#

IDS=$(aws elasticbeanstalk describe-environment-resources --environment-id e-mirmt7zidp --profile netwifi --region sa-east-1 | grep Id | cut -d\" -f4)

for ID in $IDS
do 
	#echo "IDS é : ${IDS}"
	#echo "ID é : ${ID}"
	IP=$(aws ec2 describe-instances --instance-ids $ID --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text --profile netwifi --region sa-east-1)
	echo "[beanstalk]\n${IP}" > /home/fernandocunha/Repos/Scripts/hosts
	DOCKER=$(ansible beanstalk --inventory-file /home/fernandocunha/Repos/Scripts/hosts -u ec2-user --private-key=/home/fernandocunha/Documents/Chaves/NET/NET-PROD-NV.pem -m script -a '/home/fernandocunha/Repos/Scripts/ansibleDockerID.sh' | grep -m 1 stdout | cut -d\" -f4 | cut -d\\ -f1)
	echo "EC2 ID: $ID"
	echo "EC2 IP: $IP"
	echo "Docker ID: $DOCKER"
	echo "----------------------"
done