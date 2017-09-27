#!/bin/bash
#
#Script para determinar tamanho do arquivo de log de um determinado
#BRAS.
#Recebe o IP do BRAS como paramêtro e retorna o tamanho do arquivo
#detail-IP_do_BRAS-${hoje}

#Variáveis
HOJE=$(date +%Y%m%d)
IP_BRAS=$1
LOG_DIR_ACCESS=/var/log/freeradius/radaccess

cd $LOG_DIR_ACCESS
du -sc ${LOG_DIR_ACCESS}/${IP_BRAS}/access-request-${HOJE} | grep $IP_BRAS | grep $HOJE | cut -d/ -f1

