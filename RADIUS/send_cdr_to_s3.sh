#!/bin/bash

set -e

function log {
    logger -t "send_cdr_to_s3" -- $1;
}

function die {
    [ -n "$1" ] && log "$1"
    log "Send logs files to S3 has failed!"
    exit 1
}

DIRECTORY=/var/log/freeradius
BKPDIRECTORY=/var/log/freeradius/cdr_bkp

if [ ! -d "$BKPDIRECTORY" ]; then
        mkdir $BKPDIRECTORY
fi

cd $DIRECTORY

FILES=$(find -type f -mmin +10 -name "cdr-*" -not -path "./cdr_bkp/*" | sort | cut -d\/ -f2);


if [ ! -n "${FILES}" ]; then
        log "List of files is empty!";
        die;
fi


for FILE in ${FILES}; do 
        YEAR=$(echo ${FILE} | cut -d\- -f3 | cut -c 1-4); 
        MONTH=$(echo ${FILE} | cut -d\- -f3 | cut -c 5-6);
        DAY=$(echo ${FILE} | cut -d\- -f3 | cut -c 7-8);
  
        log "${FILE} - ANO=${YEAR} - MES=${MONTH} - DIA=${DAY}"; 

        #aws s3 cp ${FILE} s3://netwifi-acct-cdr-log/mcare-freeradius/${YEAR}/${MONTH}/${DAY}/${FILE}_$(hostname).log > /tmp/transfer.txt
        #aws s3 cp ${FILE} s3://netwifi-acct-cdr-log/mcare-freeradius/year=${YEAR}/month=${MONTH}/day=${DAY}/${FILE}_$(hostname).log > /tmp/transfer.txt
        aws s3 cp ${FILE} s3://netwifi-acct-cdr-log/mcare-freeradius/dt=${YEAR}-${MONTH}-${DAY}/${FILE}_$(hostname).log > /tmp/transfer.txt

        log "$(cat /tmp/transfer.txt)";

        log "moving file to backup dir ${BKPDIRECTORY}";
        mv ${FILE} $BKPDIRECTORY/${FILE};

done