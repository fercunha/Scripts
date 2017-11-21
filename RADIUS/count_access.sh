#!/bin/bash
#
# Script para contar a quanditidade de mensagens ACCESS e ACCT recebidas por BRAS.

### Variaveis gerais do script
ACCESS_LOG_DIR=/var/log/freeradius/radaccess
ACCT_LOG_DIR=/var/log/freeradius/radacct
HOSTNAME=$(/bin/hostname -s)
hoje=$(date +%Y-%m-%d)
ontem=$(date --date="yesterday" +"%Y%m%d")
LISTA_BRAS="$1"

cd $ACCESS_LOG_DIR

while read BRAS
do
	#printf "$BRAS"
	#cd ${ACCESS_LOG_DIR}/${BRAS}
	#pwd
	echo "Acessando ${ACCESS_LOG_DIR}/${BRAS}/"
	echo "Lendo arquivo access-request-${ontem}.gz"
	PACKET=$(gzip -d < ${ACCESS_LOG_DIR}/${BRAS}/access-request-${ontem}.gz | grep Packet-Type | wc -l)
	echo ${BRAS},${PACKET} | tee >> ./count_access_${HOSTNAME}_${hoje}.csv	

done < $LISTA_BRAS