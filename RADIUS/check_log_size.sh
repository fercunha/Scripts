#!/bin/bash
#
#Script para determinar tamanho do arquivo de log de um determinado
#BRAS.
#Recebe o IP do BRAS como paramêtro e retorna o tamanho do arquivo
#detail-IP_do_BRAS-${hoje}

#Variáveis
HOJE=$(date +%Y%m%d)
TYPE=$1
IP_BRAS=$2
LOG_DIR_ACCESS=/var/log/freeradius/radaccess
LOG_DIR_ACCT=/var/log/freeradius/radacct

if [ $TYPE=auth ];
	then
		cd $LOG_DIR_ACCESS
		du -sc ${LOG_DIR_ACCESS}/${IP_BRAS}/access-request-${HOJE} | grep $IP_BRAS | grep $HOJE | cut -d/ -f1
elif [ $TYPE=acct ];
	then
		cd $LOG_DIR_ACCT
		du -sc $LOG_DIR_ACCT | grep $IP_BRAS | grep $HOJE | cut -dd -f1
else
	echo "Erro"

fi

