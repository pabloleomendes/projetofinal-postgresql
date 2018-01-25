#!/bin/bash
set -e

POSTGRESQL_USER=${POSTGRESQL_USER:-"docker"}
POSTGRESQL_PASS=${POSTGRESQL_PASS:-"docker"}
POSTGRESQL_DB=${POSTGRESQL_DB:-"docker"}
POSTGRESQL_TEMPLATE=${POSTGRESQL_TEMPLATE:-"DEFAULT"}

POSTGRESQL_BIN=/usr/local/pgsql9.6.2/bin/postgres
POSTGRESQL_CONFIG_FILE=/data/db/postgresql.conf
POSTGRESQL_DATA=/data/db

POSTGRESQL_SINGLE="sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE"

export PGDATA=/data/db/

arquivo=`date +%Y-%m-%d_%H-%M`
mkdir -p /data/backup/pitr
#mkdir -p /data/backup/pitr/$arquivo
#ln -s /data/backup/pitr/atual /data/backup/pitr/$arquivo
mkdir -p /data/backup/pitr/atual/wals
chown -R postgres:postgres /data/backup/

if [ ! -f $POSTGRESQL_CONFIG_FILE ]; then
    #mkdir -p $POSTGRESQL_DATA
    rm -Rf /data/db/*
    chown -R postgres:postgres $POSTGRESQL_DATA
    sudo -u postgres /usr/local/pgsql9.6.2/bin/initdb -D $POSTGRESQL_DATA -E 'UTF-8'
#    ln -s /etc/ssl/certs/ssl-cert-snakeoil.pem $POSTGRESQL_DATA/server.crt
#    ln -s /etc/ssl/private/ssl-cert-snakeoil.key $POSTGRESQL_DATA/server.key
fi

cp /sbin/pg_hba.conf /sbin/postgresql.conf $POSTGRESQL_DATA

#$POSTGRESQL_SINGLE <<< "CREATE USER $POSTGRESQL_USER WITH SUPERUSER;" > /dev/null
#$POSTGRESQL_SINGLE <<< "ALTER USER $POSTGRESQL_USER WITH PASSWORD '$POSTGRESQL_PASS';" > /dev/null
#$POSTGRESQL_SINGLE <<< "CREATE DATABASE $POSTGRESQL_DB OWNER $POSTGRESQL_USER TEMPLATE $POSTGRESQL_TEMPLATE;" > /dev/null

#exec start-stop-daemon --start --chuid postgres:postgres --exec /usr/local/pgsql9.6.2/bin/postgres -D /data/db

exec sudo -u postgres $POSTGRESQL_BIN -D /data/db --config-file=$POSTGRESQL_CONFIG_FILE
