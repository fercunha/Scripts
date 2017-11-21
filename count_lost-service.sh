#!/bin/bash	
#
# Script para contar a quanditidade de mensagens ACCESS e ACCT recebidas por BRAS.

### Variaveis gerais do script
DIR=/home/fernandocunha/Documents/Oi/Oi-Wifi/Problema_SessaoCurta
HOSTNAME=$(/bin/hostname -s)
hoje=$(date +%Y-%m-%d)
ontem=$(date --date="yesterday" +"%Y%m%d")
DATAS="$1"

cd $DIR

while read DATA
do
	#printf "$BRAS"
	#cd ${ACCESS_LOG_DIR}/${BRAS}
	#pwd
	#echo "Lendo arquivo auth-${DATA}"
	#PACKET=$(cat auth-${DATA}\* | grep Lost-Service | cut -d\; -f15 | wc -l)
	for i in $(cat auth-${DATA}*) ; do

	PACKET=$(cat $i | grep Lost-Service | cut -d\; -f15 | wc -l)
	echo ${DATA},${PACKET} | tee > ./count_lost-service_${HOSTNAME}_${hoje}.csv	

	done

done < $DATAS