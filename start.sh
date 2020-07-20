#!/bin/bash

time=$(date +"%Y-%m-%d %H:%M:%S")

check_new_port() {
	sleep 3s
	log_file=/mnt/AHD1-1/Project/ubuntu/MCSManager-master/server/tmp_log_history/MilkTown_BE.log
	
	while [[ "$(cat $log_file | grep "IPv4 supported, port: ")" == "" ]]
	do
		echo "[$time INFO]" Checking the second IPv4 port
		sleep 1s
	done
	
	new_port=$(cat $log_file | grep "IPv4 supported, port: " | sed -n '2p' | cut -d ' ' -f 7)
	echo "[$time INFO]" Detected the second IPv4 port: $new_port
}

update_frp() {
	frp_file=/usr/local/frp/frpc.ini
	old_port=$(cat $frp_file | grep "BE-p2" | cut -d " " -f 3)
	
	echo "[$time INFO]"  Updating frpc config
	sed -i "s/$old_port/$new_port/g" $frp_file
	
	echo "[$time INFO]"  Reloading frpc config
	result=$(/usr/local/frp/frpc -c /usr/local/frp/frpc.ini reload)
	if [[ "$result" == "reload success" ]]
	then echo "[$time INFO]"  Reloaded frpc config successfully
	fi
}

preboot() {
	check_new_port
	update_frp
}

preboot &

LD_LIBRARY_PATH=. ./bedrock_server
