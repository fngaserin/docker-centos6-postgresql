FROM centos:centos6
MAINTAINER Felix Ngaserin <felix@nusapro.com>

RUN ["yum","-y","update"]
RUN yum install -y http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
RUN yum install -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum install -y postgresql93-server pgtune

EXPOSE 5432

ADD postgres-launch.sh /postgres-launch.sh
RUN chmod 755 /postgres-launch.sh


CMD ["/bin/bash","-c","/postgres-launch.sh"]
