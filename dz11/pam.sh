#!/usr/bin/env bash

# Проверяем принадлежность пользователя к группе admin
if groups $PAM_USER | grep -c admin ; then
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
exit 1
