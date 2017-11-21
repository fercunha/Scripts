#!/bin/bash
# Script verifica o Docker ID
#

sudo docker ps --format "table {{.ID}}" | grep -v "CONTAINER ID"