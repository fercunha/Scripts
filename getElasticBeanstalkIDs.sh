#!/bin/bash

aws elasticbeanstalk describe-environment-resources --environment-id e-muqbipfvq5 --profile netwifi --region us-east-1 | grep Id | cut -d\" -f4