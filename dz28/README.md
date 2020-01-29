# Домашнее задание
Кластер PostgreSQL на Patroni
Развернуть кластер PostgreSQL из трех нод. Создать тестовую базу - проверить статус репликации
Сделать switchover/failover
Поменять конфигурацию PostgreSQL + с параметром требующим перезагрузки
* Настроить клиентские подключения через HAProxy
** Настроить пулер соединений на базе pgbouncer либо pgpool

Все результаты приложить описанием в MD либо скриншотами. Можно совместить.

## Проверки
Проверка репликации:

```console
[root@pg1 vagrant]# psql -h 192.168.1.21
psql (9.2.24, server 11.6)
WARNING: psql version 9.2, server version 11.0.
         Some psql features might not work.
Type "help" for help.

postgres=# create database test;
CREATE DATABASE
postgres=# \l
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   
-----------+----------+----------+-------------+-------------+-----------------------
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 test      | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
(4 rows)

postgres=# \q
[root@pg1 vagrant]# psql -h 192.168.1.22
psql (9.2.24, server 11.6)
WARNING: psql version 9.2, server version 11.0.
         Some psql features might not work.
Type "help" for help.

postgres=# \l
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   
-----------+----------+----------+-------------+-------------+-----------------------
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 test      | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
(4 rows)

postgres=# \q
[root@pg1 vagrant]# psql -h 192.168.1.23
psql (9.2.24, server 11.6)
WARNING: psql version 9.2, server version 11.0.
         Some psql features might not work.
Type "help" for help.

postgres=# \l
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   
-----------+----------+----------+-------------+-------------+-----------------------
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 test      | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
(4 rows)
```

Проверка automatic failover:
