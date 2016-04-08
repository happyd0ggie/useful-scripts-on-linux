#!/bin/bash

# get ethN
get_ethn()
{
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
