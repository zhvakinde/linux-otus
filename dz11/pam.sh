#!/usr/bin/env bash

# Проверяем принадлежность пользователя к группе admin
if [[ groups $PAM_USER | grep &>/dev/null '\b admin \b']] ; then
echo "You are in the admin group."
       exit 0
    else
fi
# Проверяем день. Если 0, то рабочий день.
# Воспользуемся сервисом https://isdayoff.ru/
# Если сервис недоступен, то никого не пускать, кроме группы admin.
if [[ $(curl -s https://isdayoff.ru/$(date +%y%m%d)) -eq 0 ]]; then
    exit 0
fi
# Отказ по-умочанию.
echo "Login denied.
exit 1
