FROM centos:centos6
MAINTAINER Felix Ngaserin <felix@nusapro.com>

RUN ["yum","-y","update"]
RUN yum install -y http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
RUN yum install -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum install -y postgresql93-server pgtune

EXPOSE 5432

ENV PGDATA /var/lib/pgsql/9.3/data
USER postgres

RUN /usr/pgsql-9.3/bin/initdb --locale=en_US.UTF-8
RUN pgtune -T Web -i $PGDATA/postgresql.conf > $PGDATA/local.conf
RUN echo "listen_addresses='*'" >> $PGDATA/local.conf
RUN echo "include = 'local.conf'" >> $PGDATA/postgresql.conf
RUN echo "local all all trust" > $PGDATA/pg_hba.conf
RUN echo "host all all 127.0.0.1/32 trust" >> $PGDATA/pg_hba.conf
RUN echo "host all all 0.0.0.0/0 trust" >> $PGDATA/pg_hba.conf
RUN echo "fsync=off" >> $PGDATA/local.conf

USER root

CMD su - postgres -c '/usr/pgsql-9.3/bin/postgres -D $PGDATA'
