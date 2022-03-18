#!/bin/bash -ex

# load config
#. "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/config.sh"


renewssl(){
  json=$(cat <<-END
    {
      "apikey": "${dnsExitToken}",
      "domain": "${dnsExitBaseDomain}",
      "action": "renew",
      "verbose": "true"
    }
END
)

  # write json file
  echo "${json}" > update.json

  # save txt record
  curl  -H "Content-Type: application/json" --data @update.json https://api.dnsexit.com/dns/lse.jsp > renew.json
}

get_status(){
  json=$(cat <<-END
    {
      "apikey": "${dnsExitToken}",
      "domain": "${dnsExitBaseDomain}",
      "action": "query",
      "verbose": "false"
    }
END
)

  # write json file
  echo "${json}" > update.json

  # save txt record
  curl  -H "Content-Type: application/json" --data @update.json https://api.dnsexit.com/dns/lse.jsp > date.json
}

check4old(){
  if ! test -f "date.json"; then
    get_status
  fi
  data=$(grep -o '"expiration date":"[^"]*' date.json)
  expire=${data:19}
  data=$(grep -o '"expiration date":"[^"]*' $1)
  filedate=${data:19}
  renew=$(( ($(date --date $expire +%s) - $(date --date $filedate +%s) )/(60*60*24) ))
  echo $renew
}


date2update(){
  if ! test -f "date.json"; then
    get_status
  fi
  data=$(grep -o '"expiration date":"[^"]*' date.json)
  expire=${data:19}
  renew=$(( ($(date --date $expire +%s) - $(date +%s) )/(60*60*24) ))
  echo $renew
}


document() {
 	json=$(cat <<-END
  	   {
    	     "apikey": "${dnsExitToken}",
             "domain": "${dnsExitBaseDomain}",
             "action": "download",
             "file": "$1"
           }
END
)
        # write json file
        echo "${json}" > update.json

        # save txt record
        curl  -H "Content-Type: application/json" --data @update.json https://api.dnsexit.com/dns/lse.jsp > junkitfile
	grep -v -E '^$|Expiration' junkitfile > $2
	rm junkitfile
}

docappend() {
 	json=$(cat <<-END
  	   {
    	     "apikey": "${dnsExitToken}",
             "domain": "${dnsExitBaseDomain}",
             "action": "download",
             "file": "$1"
           }
END
)
        # write json file
        echo "${json}" > update.json

        # save txt record
        curl  -H "Content-Type: application/json" --data @update.json https://api.dnsexit.com/dns/lse.jsp > junkitfile
	grep -v -E '^$|Expiration' junkitfile >> $2
	rm junkitfile
}

