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
```console
[root@pg1 vagrant]# patronictl list otus
+---------+--------+--------------+--------+---------+----+-----------+
| Cluster | Member |     Host     |  Role  |  State  | TL | Lag in MB |
+---------+--------+--------------+--------+---------+----+-----------+
|   otus  |  pg1   | 192.168.1.21 | Leader | running |  1 |           |
|   otus  |  pg2   | 192.168.1.22 |        | running |  1 |       0.0 |
|   otus  |  pg3   | 192.168.1.23 |        | running |  1 |       0.0 |
+---------+--------+--------------+--------+---------+----+-----------+
[root@pg1 vagrant]# systemctl stop patroni
[root@pg1 vagrant]#  patronictl list otus
+---------+--------+--------------+--------+---------+----+-----------+
| Cluster | Member |     Host     |  Role  |  State  | TL | Lag in MB |
+---------+--------+--------------+--------+---------+----+-----------+
|   otus  |  pg2   | 192.168.1.22 | Leader | running |  2 |           |
|   otus  |  pg3   | 192.168.1.23 |        | running |  2 |       0.0 |
+---------+--------+--------------+--------+---------+----+-----------+
```

Проверка switchover:
```console
[root@pg1 vagrant]#  patronictl list otus
+---------+--------+--------------+--------+---------+----+-----------+
| Cluster | Member |     Host     |  Role  |  State  | TL | Lag in MB |
+---------+--------+--------------+--------+---------+----+-----------+
|   otus  |  pg1   | 192.168.1.21 |        | running |  1 |       0.0 |
|   otus  |  pg2   | 192.168.1.22 | Leader | running |  2 |           |
|   otus  |  pg3   | 192.168.1.23 |        | running |  2 |       0.0 |
+---------+--------+--------------+--------+---------+----+-----------+
[root@pg1 vagrant]# patronictl switchover --master pg2 --candidate pg1 otus
When should the switchover take place (e.g. 2020-01-29T15:26 )  [now]: 
Current cluster topology
+---------+--------+--------------+--------+---------+----+-----------+
| Cluster | Member |     Host     |  Role  |  State  | TL | Lag in MB |
+---------+--------+--------------+--------+---------+----+-----------+
|   otus  |  pg1   | 192.168.1.21 |        | running |  2 |       0.0 |
|   otus  |  pg2   | 192.168.1.22 | Leader | running |  2 |           |
|   otus  |  pg3   | 192.168.1.23 |        | running |  2 |       0.0 |
+---------+--------+--------------+--------+---------+----+-----------+
Are you sure you want to switchover cluster otus, demoting current master pg2? [y/N]: y
2020-01-29 14:26:28.47958 Successfully switched over to "pg1"
+---------+--------+--------------+--------+---------+----+-----------+
| Cluster | Member |     Host     |  Role  |  State  | TL | Lag in MB |
+---------+--------+--------------+--------+---------+----+-----------+
|   otus  |  pg1   | 192.168.1.21 | Leader | running |  2 |           |
|   otus  |  pg2   | 192.168.1.22 |        | stopped |    |   unknown |
|   otus  |  pg3   | 192.168.1.23 |        | running |  2 |       0.0 |
+---------+--------+--------------+--------+---------+----+-----------+
```

Проверка (Поменять конфигурацию PostgreSQL + с параметром требующим перезагрузки)
```console
[root@pg1 vagrant]# patronictl edit-config otus
--- 
+++ 
@@ -9,7 +9,7 @@
     archive_mode: 'on'
     max_connections: 100
     max_parallel_workers: 8
-    max_wal_senders: 5
+    max_wal_senders: 10
     max_wal_size: 2GB
     min_wal_size: 1GB
   use_pg_rewind: true

Apply these changes? [y/N]: y
Configuration changed
[root@pg1 vagrant]# patronictl list otus
+---------+--------+--------------+--------+---------+----+-----------+-----------------+
| Cluster | Member |     Host     |  Role  |  State  | TL | Lag in MB | Pending restart |
+---------+--------+--------------+--------+---------+----+-----------+-----------------+
|   otus  |  pg1   | 192.168.1.21 | Leader | running |  3 |           |        *        |
|   otus  |  pg2   | 192.168.1.22 |        | running |  3 |       0.0 |        *        |
|   otus  |  pg3   | 192.168.1.23 |        | running |  3 |       0.0 |        *        |
+---------+--------+--------------+--------+---------+----+-----------+-----------------+
[root@pg1 vagrant]# patronictl restart otus
+---------+--------+--------------+--------+---------+----+-----------+-----------------+
| Cluster | Member |     Host     |  Role  |  State  | TL | Lag in MB | Pending restart |
+---------+--------+--------------+--------+---------+----+-----------+-----------------+
|   otus  |  pg1   | 192.168.1.21 | Leader | running |  3 |           |        *        |
|   otus  |  pg2   | 192.168.1.22 |        | running |  3 |       0.0 |        *        |
|   otus  |  pg3   | 192.168.1.23 |        | running |  3 |       0.0 |        *        |
+---------+--------+--------------+--------+---------+----+-----------+-----------------+
When should the restart take place (e.g. 2020-01-29T15:29)  [now]: 
Are you sure you want to restart members pg2, pg3, pg1? [y/N]: y
Restart if the PostgreSQL version is less than provided (e.g. 9.5.2)  []: 
Success: restart on member pg2
Success: restart on member pg3
Success: restart on member pg1
```
