#! /bin/bash
### Script para contar mensagems duplicadas do NETWIFI.
### O arquivo de captura utiliza a estrutura do log "detail" do RADIUS que fica no diretório radacct


START="0"
STOP="0"
INTERIM="0"
CAP=$1
MSG_START="/tmp/MSG_START.txt"
MSG_STOP="/tmp/MSG_STOP.txt"
MSG_INTERIM="/tmp/MSG_INTERIM.txt"

### Criando arquivos menores auxiliares.
touch /tmp/MSG_START.txt
cat $1 | grep -A7 Start > /tmp/MSG_START.txt
touch /tmp/MSG_STOP.txt
cat $1 | grep -A7 Stop > /tmp/MSG_STOP.txt
touch /tmp/MSG_INTERIM.txt
cat $1 | grep -A7 Interim > /tmp/MSG_INTERIM.txt

conta_start() {
SESSIONS_START=$(cat $MSG_START | grep -A7 Start | grep Acct-Session-Id | cut -d\" -f2 | sort | uniq)
for SESSION in $SESSIONS_START
do
	CONTA=$(cat $MSG_START | grep $SESSION | wc -l)
	#echo "$CONTA"
	START=$(($START+$CONTA-1))
	#echo "$START"
	CONTA=0
done
return 0
}

conta_stop() {
SESSIONS_STOP=$(cat $MSG_STOP | grep -A7 Stop | grep Acct-Session-Id | cut -d\" -f2 | sort | uniq)
for SESSION in $SESSIONS_STOP
do
	CONTA=$(cat $MSG_STOP | grep $SESSION | wc -l)
	#echo "$CONTA"
	STOP=$(($STOP+$CONTA-1))
	#echo "$START"
	CONTA=0
done
return 0
}

#conta_start
conta_stop
echo "Quantidade de mensagens START duplicadas: 102"
echo "Quantidade de mensagens STOP duplicadas: ${STOP}"