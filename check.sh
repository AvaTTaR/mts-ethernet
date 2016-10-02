#!/bin/bash        
export LANG='C.UTF-8'

# Скрипт проверки тарифного плана, возвращает номер

uname="000000000" # ваш логин (начинается на 00)
pass="0000000" # ваш пароль
uagent="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36" # юзер-агент

curl -s "https://ihelper.mts.by/SelfCarePda/Security.mvc/LogOn" --ciphers "3DES" -A "$uagent" -c "cookies.txt" --data-urlencode "username=$uname" --data-urlencode "password=$pass" > /dev/null # логинимся, получаем куки

curl -s "https://ihelper.mts.by/SelfCarePda/Product.mvc" --ciphers "3DES" -A "$uagent" -b "cookies.txt" | grep -ozP '<p>\s*Домашний коннект \K[^\.]*' # получаем номер тарифа со страницы "Список услуг"

rm cookies.txt # удаляем куки