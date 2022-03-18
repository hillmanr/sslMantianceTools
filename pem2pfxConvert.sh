#!/bin/bash -ex

# load config & functions
. "$(  pwd )/config.sh"
. "$(  pwd )/base.sh"


needed=0
if [ $(date2update "$(date +%D)") -lt 30  ]; then
   	renewssl 
fi

document privatekey > privateKey.key
document cert > certificate.crt
document ca > CACert.crt
openssl pkcs12 -export -out $sslDir$sslcert -inkey privateKey.key -in certificate.crt -certfile CACert.crt

chmod 666 $sslDir$sslcert
rm privateKey.key certificate.crt  CACert.crt
rm date.json
rm update.json
#rm renew.json

