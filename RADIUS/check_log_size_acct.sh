#!/bin/bash
#
#Script para determinar tamanho do arquivo de log de um determinado
#BRAS.
#Recebe o IP do BRAS como paramêtro e retorna o tamanho do arquivo
#detail-IP_do_BRAS-${hoje}

#Variáveis
HOJE=$(date +%Y%m%d)
IP_BRAS=("186.207.162.55", "189.34.253.205", "189.4.5.134", "189.6.46.8", "201.17.169.8", "201.17.36.38", "201.21.213.38", "201.6.24.134", "201.6.24.172", "201.6.24.182", "201.6.24.183", "201.82.14.134")
LOG_DIR_ACCT=/var/log/freeradius/radacct

for BRAS in $IP_BRAS
do
	cd $LOG_DIR_ACCT
	SIZE=$(du -sc $LOG_DIR_ACCT | grep $IP_BRAS | grep $HOJE | cut -dd -f1)
	echo $SIZE

done