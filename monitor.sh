#!/bin/bash
export LANG='C.UTF-8'

# Скрипт мониторинга устройства в сети

ip="192.168.1.107" # IP-адрес устрйства, за которым следим
tarif=$(bash check.sh) # проверяем текущий тариф
low=1 # экономный тариф (ДК-1), если устройство не включено
high=3 # быстрый тариф (ДК-3), если устройство включено

echo -e "\nТекущий тариф: \"Домашний коннект $tarif\"\n"

while true # бесконечный цикл
do
	if ping $ip -n 1 | grep TTL > /dev/null # если устройство в сети
	then 
		if [ $tarif != $high ] # если тариф не ДК-3
		then
			echo [ `date +"%Y-%m-%d %T"` ]
			bash change.sh $high # ставим ДК-3
			tarif=$high
		fi
	else # устройство не в сети
		if [ $tarif != $low ] # если тариф не ДК-1
		then 
			echo [ `date +"%Y-%m-%d %T"` ]
			bash change.sh $low # ставим ДК-1
			tarif=$low
		fi
	fi
	sleep 10 # проверка каждые 10 секунд
done