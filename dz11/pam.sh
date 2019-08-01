if groups $PAM_USER | grep &>/dev/null '\b{{ admin }}\b'; then
    echo "You are in the {{ admin }} group."
    exit 0
    else
    echo "You are not in the {{ admin }} group."
fi
# Проверяем день. Если 0, то рабочий день.
# Воспользуемся сервисом https://isdayoff.ru/
# Если сервис недоступен, то никого не пускать, кроме группы {{ admin }}.
if [[ $(curl -s https://isdayoff.ru/$(date +%y%m%d)) -eq 0 ]]; then
    exit 0
fi
# Отказ по-умочанию.
echo "Login denied. Today is a day off! Probably..."
exit 1
