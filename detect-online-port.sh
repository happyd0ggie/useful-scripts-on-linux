#!/bin/bash

# get ethN
get_ethn()
{
<<<<<<< HEAD
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
=======
	ifconfig -a | grep -iE "eth.*" | awk -F " " '{ print $1, $5 }' > ethn.list
}

# get linked status
get_linked()
{
	eths='./ethn.list'
	echo -e "PORT\tLINKED\tMAC\t\t\tIP"
	echo "====================================================="
	while read line
	do
		eth=(${line})
		port=${eth[0]}
		mac=${eth[1]}
		res=`ethtool ${port} | grep -i detected | awk -F " " '{ print $3 }'`
		ip=`ifconfig ${port} | grep -i addr: | awk -F " " '{ print $2 }' | awk -F ":" '{ print $2 }'`
		# echo ${port}
		# echo ${mac}
		# echo ${ip}
		echo -n ${port}
		echo -n -e "\t"
		echo -n ${res}
		echo -n -e "\t"
		echo -n ${mac}
		echo -n -e "\t"
		echo ${ip}
	done < ${eths}
	echo "====================================================="
}

get_ethn
get_linked
>>>>>>> 3be60d991f13e275d691603fc0dd4b12aa7c7403
