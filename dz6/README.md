Домашнее задание
Создать свой RPM пакет (возьмем пакет NGINX и соберем его с поддержкой openssl)
Создать свой репозиторий и разместить там ранее собранный RPM

    Устанавливаются нужные пакеты для работы:

yum install -y \
redhat-lsb-core \
wget \
rpmdevtools \
rpm-build \
createrepo \
yum-utils \


Загрузим SRPM пакет NGINX длa дальнейшей работы над ним:

wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm

rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm

Также нужно скачать и разархивировать последнии исходники для openssl - он потребуется при сборке

wget https://www.openssl.org/source/latest.tar.gz

Заранее устанавливаются зависимости:

sudo yum-builddep rpmbuild/SPECS/nginx.spec

Исправляем spec файл (приложен к этой инструкции)

Собираем пакет RPM
rpmbuild -bb rpmbuild/SPECS/nginx.spec


Создать свой репозиторий и разместить там ранее собранный RPM
Репозиторий создаем в Vagrant 
  

Все готово для того, чтобы протестировать репозиторий.

Добавим его в /etc/yum.repos.d:
cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF



Убедимся что репозиторий подключился и посмотрим что в нем есть:

 yum repolist enabled | grep otus

 yum list | grep otus


устанавливаем NGINX
 yum install nginx -y

  