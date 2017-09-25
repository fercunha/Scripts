#!/bin/bash

### Inserir no Logrotate e manter comentado no script - Apenas doc.
#/var/log/freeradius/*.log /var/log/http-inbound2/console.log {
#daily        
#copytruncate
#missingok
#rotate 60
#dateext
#dateformat .%Y-%m-%d
#create 644 freerad freerad
#}

### Informar var $1,$2 e $3 caso necessario. Caso contrario irá usar o default
### $1 Nome do bucket - $2 Profile p/ aws cli - $3 Regiao p/ aws cli

### Variaveis gerais do script
FREERADIUS_LOG_DIR=/var/log/freeradius
HTTP_INBOUND_LOG_DIR=/var/log/http-inbound2
LOGS_DIR=( "${FREERADIUS_LOG_DIR}" "${HTTP_INBOUND_LOG_DIR}" )
HOSTNAME=$(/bin/hostname -s)
BUCKET_S3=${1:-netwifi-backup-sp}
PROFILE_AWS=${2:-default}
REGION_AWS=${3:-sa-east-1}
hoje=$(date +%Y-%m-%d)
ontem=$(date --date="yesterday" +"%Y-%m-%d")

### Altera o nome do arquivo feito via logrotate
### Navega até o DIR para evitar mudança de padrao
for log_dir in "${LOGS_DIR[@]}"

do
        cd ${log_dir}
        LISTA=$(find . -type f \( -iname "*.log.${hoje}"  ! -iname "httpinbound2*" \) -not -path "*/buffered/*" )
                for I in ${LISTA};

                do

                        LIMPANOME=$(echo $I | cut -d '/' -f 2 | sed 's/.'${hoje}'//')

                mv ${I} ${log_dir}/${LIMPANOME}.${ontem}

                done
done

### Compactando logs ### ATENCAO! Nao Compacta arquivos na pasta Buffered 
### Compacta todos os arquivos com + de 5 dias sem .gz
for log_dir in "${LOGS_DIR[@]}"

do

        find ${log_dir}/ -mmin +$((60*3)) -type f ! -iname "*.gz" -not -path "*/buffered/*" -exec gzip -9 {} \;

        ### Envia arquivos com mais de 3 dias para a AWS

        for envia_aws in $(find ${log_dir}/ -mtime +3 -type f -iname "*.gz" -not -path "*/buffered/*" )
        do 

        aws s3 mv ${envia_aws} s3://${BUCKET_S3}/${HOSTNAME}${envia_aws} --profile=${PROFILE_AWS} --region=${REGION_AWS}

        done

done