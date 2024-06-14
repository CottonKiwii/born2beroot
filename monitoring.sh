#! /bin/bash

arc=$(uname -a)
cpup=$(cat /proc/cpuinfo | grep "cpu cores" | awk 'END {printf "%d", $NF}')
cpuv=$(nproc) 
mem=$(free -m | grep "Mem:" | awk '{printf "%d/%dMB (%.2f%%)", $3, $2, ($3/$2) * 100}')
disk=$(df -BMB | grep "/dev/mapper/" | awk '{used+=$3} {total+=$2} END {printf "%d/%dMB (%d%%)",used, total, (used/total) * 100}')
cpul=$(mpstat | awk 'END {printf "%.2f%%", 100 - $NF}')
boot=$(who -b | awk '{printf "%s %s", $3, $NF}')
lvm=$(if [ $(lsblk | grep "lvm" | wc -l) = 0 ]; then echo no; else echo yes; fi)
con=$(netstat -ntu | grep "ESTABLISHED" | wc -l)
user=$(users | wc -w)
ip=$(hostname -I)
mac=$(ip link show | grep ether | awk '{printf "%s", $2}')
sudo=$(cat /var/log/sudo/sudo.log | grep "COMMAND" | wc -l)

wall "	#Architecture:	$arc
	#Physical CPU:	$cpup
	#Virtual CPU:	$cpuv
	#Memory Usage:	$mem
	#Disk Usage:	$disk
	#CPU Load:	$cpul
	#Last Boot:	$boot
	#LVM Use:	$lvm
	#Connections:	$con ESTABLISHED
	#User Log:	$user
	#Network:	IP $ip ($mac)
	#Sudo:		$sudo cmd"
