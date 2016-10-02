#!/bin/bash        
export LANG='C.UTF-8'

# Скрипт смены тарифного плана
# Пример:
# - сменить тарифный план на ДК-1:
# 	bash change.sh 1

uname="000000000" # ваш логин (начинается на 00)
pass="0000000" # ваш пароль
uagent="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36" # юзер-агент

dk[1]=45691 # ДК-1
dk[2]=45694 # ДК-2
dk[3]=45697 # ДК-3
dk[4]=45701 # ДК-4
dk[5]=54256 # ДК-5
product=${dk[$1]} # читаем из аргументов скрипта номер тарифа

curl -s "https://ihelper.mts.by/SelfCarePda/Security.mvc/LogOn" --ciphers "3DES" -A "$uagent" -c "cookies.txt" --data-urlencode "username=$uname" --data-urlencode "password=$pass" > /dev/null # логинимся, получаем куки

curl -s "https://ihelper.mts.by/SelfCarePda/Product.mvc/Add" --ciphers "3DES" -A "$uagent" -b "cookies.txt" > /dev/null # открываем страницу

tarifname=`curl -s "https://ihelper.mts.by/SelfCarePda/Product.mvc/Add" --ciphers "3DES" -A "$uagent" -b "cookies.txt" --data-urlencode "products=$product" --data-urlencode "Step2=Далее >" | grep -ozP '"product-add-prices">\s*<span>\K[^\.]*'` # выбираем тариф

echo -e "- Меняю тариф на \"$tarifname\"\n"

curl -s "https://ihelper.mts.by/SelfCarePda/Product.mvc/Add" --ciphers "3DES" -A "$uagent" -b "cookies.txt" --data-urlencode "Complete=Подключить услуги" > /dev/null # подтверждаем

curl -s "https://ihelper.mts.by/SelfCarePda/Security.mvc/LogOff" --ciphers "3DES" -A "$uagent" -b "cookies.txt" > /dev/null # выходим

rm cookies.txt # удаляем куки