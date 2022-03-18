# sslMantianceTools


Using a wildcard ssl certificate for home servers is convenient to use if you has multiple servers for which you would like ssl certificates. 
I needed something simple to use on multiple nodes and multiple os/vm/docker/etc environments. I am using bash since it's the minimum common capability across a VM to a minimally configured jail or docker. 
Using cron where available to automatically update when necessary. This set of tools is therefore used to update 
the tool set and the ssl wildcard domain certificates. Using the DNSexit api for my domain registered there. 
Utilizing sftp server to distribute the tool set across local domains to individual servers.


## SSL tools  
check2getSSL.sh - main script check current date and install certs or update if necessary  
pem2pfxConvert.sh - generates a pfx as needed for emby dvr server, openssl also needed  
base.sh - functions used by main ssl scripts  
config.master - copy to config.sh to set all configuration data settings  
cron-runcheck  - copy to /etc/cron.d/ 


## Tar tools
backupTools.sh - script to tar the tools and place them in sftp server  
updateTools.sh - script can be used to update the tool set (overkill)  
tarbase.sh - functions used by tar tools  


## Usage

1) Start by creating a subdirectory and copy tools to this directory. The tar file built with the backtools.sh script will do both.
2) Copy config.master to config.sh. This is the main control file and will never be changed by a tool update. Edit config.sh for the specific node configuration.  
a) version="003" - Three digit version number to be place on tar file when generated.  
b) dnsExitToken="user token generated ON dNSexit website"  
c) dnsExitBaseDomain="DOMAIN.org"   
d) host="nas" - Hostname of the sftp server. 
e) user="loginName" - User name used to log into sftp server.   
f) sslDir="/etc/ssl/" - directory where certificates should be places'  
g) sslcert="cert.pem" - filename required for the certificate.  
h) sslkey="private.key" - second filename if site requires two file format as shown in command example below  
i) cmd1="document privatekey $sslDir$sslkey" - Commands used to generate certificates    
j) cmd2="document cert $sslDir$sslcert"  
k) cmd3="docappend ca $sslDir$sslcert"  

## Commands

The cmd{x} contains the command to generate the certificate file. Needs to be in the format as above or blank (cmd3="") if not required. 
The first field is either "document" or "docappend" which maps to "copy to" or "append to" certificate file. The second is the certificate sub elements (cert, ca, csr, privatekey). Strange how each server want is different combination and number of files. The last field is the file name and location for the certificate.
1) cert - main ssl certificate  
2) ca - certificate authority  
3) csr - certificate request 
4) privatekey - private key 
