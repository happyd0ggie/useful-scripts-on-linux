#!/bin/bash

# get ethn
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
	printf "PORT\tLINKED\tMAC\t\t\tIP\n" 
	printf "====================================================\n"
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
		
		printf "${line}"
	        printf "\t"
		printf "${linked}"
	        printf "\t"
		printf "${mac}"
	        printf "\t"
		printf "${ip}\n"
	done < ${ethns}
	printf "====================================================\n"
}

main()
{
	clear
	if [ `id -u` -ne "0" ]; then
		printf "You must run as root.\n"
		exit 1
	fi
	get_ethn
	get_conf
	rm -f ethn
}

main
