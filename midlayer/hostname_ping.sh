#!/bin/sh

# The scripts that should run in first boot in Boxster
# usage: sh hostname_ping.sh 

# Need run xhost with kvm console
xhost +

# Get hostname
export hostname=`hostname`

# Get first intf name
#intflist=`ip link show | /bin/grep '^[[:digit:]]' | /bin/grep -v ' lo:' | /bin/awk -F: '{print $2}' | sort | tr -d '\040\011'`
intflist=`ip link show | /bin/grep '^[[:digit:]]' | /bin/grep -v ' lo:' | /bin/awk -F: '{print $2}' | awk -F\@ '{print $1}' | sort | tr -d '\040\011'`
# echo "intflist=$intflist"

for i in $intflist
do
	export ipaddr=`ip addr show $i | grep 'inet ' | awk '{print $2}' | awk -F'/' '{print $1}'`
	if [ ! -z "$ipaddr" ]; then
		echo "Got IP address '$ipaddr' on interface '$i'" >> ${ARCSIGHT_HOME}/logs/hostname_ping.log
		break
	fi
done


# if either hostname or ip is not set, then exit
if [ -z "$hostname" ]; then
        echo "Failed to get hostname." >> ${ARCSIGHT_HOME}/logs/hostname_ping.log
        exit 1
fi

if [ -z "$ipaddr" ]; then
	echo "Failed to get ip address." >> ${ARCSIGHT_HOME}/logs/hostname_ping.log
	exit 1
fi

# check if the hostname is resolvable
res=`ping -c 1 -W 3 "$hostname" | grep "1 received"` 
if [ -z "$res" ]; then
	echo "Failed to resolve hostname: $hostname." >> ${ARCSIGHT_HOME}/logs/hostname_ping.log
	exit 1
fi

echo "Succeeded in resolving hostname: $hostname." >> ${ARCSIGHT_HOME}/logs/hostname_ping.log
echo "Succeeded in resolving ip address: $ipaddr." >> ${ARCSIGHT_HOME}/logs/hostname_ping.log
exit 0

