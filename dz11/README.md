# Домашнее задание
PAM
1. Запретить всем пользователям, кроме группы admin логин в выходные и праздничные дни
* дать конкретному пользователю права работать с докером
и возможность рестартить докер сервис


Решение

sed -i "7i account required pam_exec.so /etc/pam.sh" /etc/pam.d/password-auth