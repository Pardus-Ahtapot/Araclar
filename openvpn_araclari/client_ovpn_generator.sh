#!/bin/bash
# First argument: Client identifier
KEY_DIR=/home/ahtapotops/client-configs/keys
OUTPUT_DIR=/home/ahtapotops/client-configs/files
BASE_CONFIG=/home/ahtapotops/client-configs/base.conf
cat ${BASE_CONFIG} \
    <(echo -e '<ca>') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '</ca>\n<cert>') \
    ${KEY_DIR}/${1}.crt \
    <(echo -e '</cert>\n<key>') \
    ${KEY_DIR}/${1}.key \
    <(echo -e '</key>\n<tls-auth>') \
    ${KEY_DIR}/ta.key \
    <(echo -e '</tls-auth>') \
    > ${OUTPUT_DIR}/${1}.ovpn