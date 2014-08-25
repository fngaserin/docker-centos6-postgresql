#!/bin/bash

PGDATA=${PGDATA:-"/var/lib/pgsql/9.3/data"}
CONFIG_FILE_PATH=$PGDATA/postgresql.conf

if [ ! -f $CONFIG_FILE_PATH ]; then
mkdir -p $PGDATA
chown postgres:postgres -Rf $PGDATA
su postgres -c 'echo $PGDATA'
su postgres -c '/usr/pgsql-9.3/bin/initdb --locale=en_US.UTF-8 --pgdata=$PGDATA'
su postgres -c 'pgtune -T Web -i $PGDATA/postgresql.conf > $PGDATA/local.conf'
su postgres -c 'echo "listen_addresses='"'"'*'"'"'" >> $PGDATA/local.conf'
su postgres -c 'echo "include = '"'"'local.conf'"'"'" >> $PGDATA/postgresql.conf'
su postgres -c 'echo "local all all trust" > $PGDATA/pg_hba.conf'
su postgres -c 'echo "host all all 127.0.0.1/32 trust" >> $PGDATA/pg_hba.conf'
su postgres -c 'echo "host all all 0.0.0.0/0 trust" >> $PGDATA/pg_hba.conf'
su postgres -c 'echo "fsync=off" >> $PGDATA/local.conf'

cat $PGDATA/postgresql.conf
fi

su postgres -c '/usr/pgsql-9.3/bin/postgres -D $PGDATA'
