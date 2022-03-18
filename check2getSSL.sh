#!/bin/bash -ex

# load config & functions
. "$(  pwd )/config.sh"
. "$(  pwd )/base.sh"


if [ $(date2update "$(date +%D)") -lt 30  ]; then
   	   renewssl 
fi

needed=0
if [ -f ${sslDir}date.json ];then
	diffDate=$(check4old ${sslDir}date.json)
	if [ $diffDate -gt 0  ];then
		needed=1
	fi	
else
   	needed=1
fi

if [ $needed -gt 0 ];then
	cp date.json ${sslDir}date.json
        $cmd1
        $cmd2
        $cmd3
fi


