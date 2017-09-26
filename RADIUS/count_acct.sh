#!/bin/bash
#
# Script para contar a quanditidade de mensagens ACCESS e ACCT recebidas por BRAS.

### Variaveis gerais do script
ACCT_LOG_DIR=/var/log/freeradius/radacct
HOSTNAME=$(/bin/hostname -s)
hoje=$(date +%Y-%m-%d)
ontem=$(date --date="yesterday" +"%Y%m%d")
LISTA_BRAS="$1"

cd $ACCT_LOG_DIR

while read BRAS
do
	#printf "$BRAS"
	#cd ${ACCESS_LOG_DIR}/${BRAS}
	#pwd
	echo "Acessando ${ACCT_LOG_DIR}/${BRAS}/"
	echo "Lendo arquivo detail-${BRAS}-${ontem}.gz"
	PACKET=$(gzip -d < ${ACCT_LOG_DIR}/detail-${BRAS}-${ontem}.gz | grep Acct-Status-Type | wc -l)
	echo ${BRAS},${PACKET} | tee >> ./count_acct_${HOSTNAME}_${hoje}.csv	

done < $LISTA_BRAS