
extractfilename(){
   echo  ${user}@${host}.${dnsExitBaseDomain} 
   sftp ${user}@${host}.${dnsExitBaseDomain} <<-EOF
ls workdir/ssltools-*
EOF
}


tarfilename(){
   filename=$(extractfilename)	
   filename=${filename:62}
   echo $filename
}   
removeoldtar(){
   echo  ${user}@${host}.${dnsExitBaseDomain} 
   sftp ${user}@${host}.${dnsExitBaseDomain} <<-EOF
rm workdir/ssltools-*
EOF
}

