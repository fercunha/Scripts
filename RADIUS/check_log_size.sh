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

if [ $TYPE = "auth" ];
	then
		if [ ! -e ${LOG_DIR_ACCESS}/${IP_BRAS}/access-request-${HOJE} ]
			then

			echo "0"

		else
			cd $LOG_DIR_ACCESS
			du -sc ${LOG_DIR_ACCESS}/${IP_BRAS}/access-request-${HOJE} | grep $IP_BRAS | grep $HOJE | cut -d/ -f1

		fi

elif [ $TYPE = "acct" ];
	then
		if [ ! -e $LOG_DIR_ACCT/detail-$IP_BRAS-$HOJE ]
			then

			echo "0"

		else

		cd $LOG_DIR_ACCT
		du -sc $LOG_DIR_ACCT/detail-$IP_BRAS-$HOJE| grep $IP_BRAS | grep $HOJE | cut -d/ -f1

		fi
else
	echo "Erro"

fi