# sslMantianceTools


Using a wildcard ssl certificate for home servers is convenient to use if you has multiple servers for which you would like ssl certificates. 
I needed something simple to use on multiple nodes and multiple os/vm/docker/etc environments.  
I am using bash since it's the minimum common capability across a VM to a minimally configured jail or docker. 
Using cron where available to automatically update when necessary. This set of tools is therefore used to update 
the tool set and the ssl wildcard domain certificates. Using the DNSexit api for my domain registered there. 
Utilizing sftp server to distribute the tool set across local domains to individual servers.

