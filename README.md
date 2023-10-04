
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High Number of Apache Child Processes Incident
---

This incident type refers to a situation where the number of child processes created by an Apache server reaches a high threshold, causing performance issues and potentially leading to server crashes. This can occur due to factors such as high traffic volume or misconfigured server settings. The incident requires investigation and mitigation to restore normal server functioning and prevent future occurrences.

### Parameters
```shell
export APACHE_PORT="PLACEHOLDER"

export MAX_CONNECTIONS="PLACEHOLDER"
```

## Debug

### Check the resource usage of Apache child processes
```shell
ps aux | grep apache | grep -v grep | awk '{print $2}' | xargs ps u
```

### Check Apache error logs for any issues
```shell
tail -n 100 /var/log/apache/error_log
```

### Check the number of Apache child processes
```shell
ps aux | grep apache | grep -v grep | wc -l
```

### Check Apache access logs for any unusual traffic
```shell
tail -n 100 /var/log/apache/access_log
```

### Check Apache configuration files for any misconfigurations
```shell
apachectl configtest
```

### Check server resource usage (CPU, memory, disk, network) to see if there are any bottlenecks
```shell
top
```

### Check network connections and open ports
```shell
netstat -an | grep ${APACHE_PORT}
```

### Check firewall settings
```shell
iptables -L
```

### Check system log for any relevant messages
```shell
tail -n 100 /var/log/messages
```

## Repair

### Reduce the number of processes by limiting the number of concurrent connections that can be made to Apache.
```shell


#!/bin/bash



# Set the maximum number of concurrent connections allowed

MAX_CONNECTIONS=${MAX_CONNECTIONS}



# Backup the Apache configuration file

cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak



# Edit the Apache configuration file to limit concurrent connections

sed -i "s/MaxClients.*/MaxClients $MAX_CONNECTIONS/" /etc/httpd/conf/httpd.conf



# Restart the Apache service to apply the changes

systemctl restart apache.service


```