

#!/bin/bash



# Set the maximum number of concurrent connections allowed

MAX_CONNECTIONS=${MAX_CONNECTIONS}



# Backup the Apache configuration file

cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak



# Edit the Apache configuration file to limit concurrent connections

sed -i "s/MaxClients.*/MaxClients $MAX_CONNECTIONS/" /etc/httpd/conf/httpd.conf



# Restart the Apache service to apply the changes

systemctl restart apache.service