# Домашнее задание
строим бонды и вланы
В Office1 в тестовой подсети появляется сервер с доп. интерфесами и адресами в internal сети testLAN:
- testClient1 - 10.10.10.254
- testClient2 - 10.10.10.254
- testServer1- 10.10.10.1
- testServer2- 10.10.10.1

Изолировать с помощью vlan:
testClient1 <-> testServer1
testClient2 <-> testServer2

Между centralRouter и inetRouter создать 2 линка (общая inernal сеть) и объединить их с помощью bond-интерфейса,
проверить работу c отключением сетевых интерфейсов

Результат ДЗ: vagrant файл с требуемой конфигурацией
Конфигурация должна разворачиваться с помощью ansible

* реализовать teaming вместо bonding'а (проверить работу в active-active)
** реализовать работу интернета с test машин 