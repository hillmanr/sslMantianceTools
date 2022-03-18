#!/bin/bash -ex

# load config & functions
. "$(  pwd )/config.sh"
. "$(  pwd )/tarbase.sh"

tarfile=ssltools-v${version}.tar.gz

cp config.sh config.master
removeoldtar
touch junk.json
rm *.json
rm ssltools-v*

touch ${tarfile}
tar --exclude=config.sh --exclude=${tarfile} -cvzf ${tarfile} ../ssl

scp ${tarfile} ${user}@${host}.${dnsExitBaseDomain}:workdir/
