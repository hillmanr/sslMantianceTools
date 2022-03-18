#!/bin/bash -ex

# load config & functions
. "$(  pwd )/config.sh"
. "$(  pwd )/tarbase.sh"


filename=$(tarfilename)
ver=${filename:10:3}
if [ "$version" = "$ver" ];then
      echo "no update needed"
      echo $filename
else
      echo "version $version update needed"
      scp ${user}@${host}.${dnsExitBaseDomain}:workdir/ssltools-v* .
      tar  --overwrite -xvzf $filename --directory .. 
fi	
