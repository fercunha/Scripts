#!/bin/bash
#
# Get list of Radius Clients

set -e

runtype=$1

CLIENTS='186.207.162.55,SDR_NETCOMMUNITY_COM_BR
189.34.253.205,WAG_CASA_SYSTEM_NEW_02
189.4.5.134,CTB_NETCOMMUNITY_COM_BR
189.6.46.8,BSA_NETCOMMUNITY_COM_BR
201.17.169.8,BHZ_NETCOMMUNITY_COM_BR
201.17.36.38,RJO_NETCOMMUNITY_COM_BR
201.21.213.38,POA_NETCOMMUNITY_COM_BR
201.6.24.134,SPO_UOL_NETCOMMUNITY_COM_BR
201.6.24.172,SPO_UOL2_NETCOMMUNITY_COM_BR
201.6.24.182,SPO_UOL2_NETCOMMUNITY_COM_BR_NEW
201.6.24.183,SPO_UOL_NETCOMMUNITY_COM_BR_NEW
201.82.14.134,CPS_NETCOMMUNITY_COM_BR'

if [ "${runtype}" = "discovery" ]; then
        for row in ${CLIENTS}; do
                CLIENT_IP=$(echo ${row} | cut -d\, -f1)
                CLIENT_SHORTNAME=$(echo ${row} | cut -d\, -f2)
        LIST="${LIST},\n"'\t\t{\n\t\t\t"{#CLIENT_IP}":"'${CLIENT_IP}'",\n\t\t\t"{#CLIENT_SHORTNAME}":"'${CLIENT_SHORTNAME}'"}'
        done

        echo -e '{\n\t"data":[\n'${LIST#,}'\n\t]\n}'
else
        for row in ${CLIENTS}; do
                CLIENT_IP=$(echo ${row} | cut -d\, -f1)
        CLIENT_SHORTNAME=$(echo ${row} | cut -d\, -f2)
                echo ${row}
        done
fi
