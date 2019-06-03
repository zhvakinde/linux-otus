�������� �������
������� ���� RPM ����� (������� ����� NGINX � ������� ��� � ���������� openssl)
������� ���� ����������� � ���������� ��� ����� ��������� RPM

    ��������������� ������ ������ ��� ������:

yum install -y \
redhat-lsb-core \
wget \
rpmdevtools \
rpm-build \
createrepo \
yum-utils \


�������� SRPM ����� NGINX ��a ���������� ������ ��� ���:

wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm

rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm

����� ����� ������� � ��������������� ��������� ��������� ��� openssl - �� ����������� ��� ������

wget https://www.openssl.org/source/latest.tar.gz

������� ��������������� �����������:

sudo yum-builddep rpmbuild/SPECS/nginx.spec

���������� spec ���� (�������� � ���� ����������)

�������� ����� RPM
rpmbuild -bb rpmbuild/SPECS/nginx.spec


������� ���� ����������� � ���������� ��� ����� ��������� RPM
����������� ������� � Vagrant 
  

��� ������ ��� ����, ����� �������������� �����������.

������� ��� � /etc/yum.repos.d:
cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF



�������� ��� ����������� ����������� � ��������� ��� � ��� ����:

 yum repolist enabled | grep otus

 yum list | grep otus


������������� NGINX
 yum install nginx -y

  