#!/bin/bash

# get ethN
get_ethn()
{
	ip link |\
		grep -Eio '[0-9]+: [a-z0-9]+' |\
	       	grep -iv lo |\
	       	awk -F " " '{ print $2 }' > ethn
}

# get mac
get_conf()
{
	ethns='ethn'
	echo 'PORT\tLINKED\tMAC\t\t\tIP' 
	echo "===================================================="
	while read line
	do
		# get mac
		mac=`ifconfig ${line} |\
		       	grep -Eio '([a-z0-9]{2}:){5}[a-z0-9]{2}'`

		# get ip
		ip=`ifconfig ${line} |\
		grep -Eio '([0-9]{1,3}\.){3}[0-9]{1,3}' |\
		grep -iv 255`

		# get if linked
		linked=`ethtool ${line} |\
		    grep -i detected |\
		    awk -F " " '{ print $3 }'`
		
		echo -n ${line}
	        echo -n '\t'
		echo -n ${linked}
	        echo -n '\t'
		echo -n ${mac}
	        echo -n '\t'
		echo ${ip}
	done < ${ethns}
	echo "===================================================="
}

clear
get_ethn
get_conf
rm -f ethn
