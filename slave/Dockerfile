FROM projetofinalbase:v1
MAINTAINER Pablo Leonardo Mendes da Cruz Lima, pabloleomendes@gmail.com

COPY ./asserts/pg_hba.conf /sbin/pg_hba.conf
COPY ./asserts/postgresql.conf /sbin/postgresql.conf
COPY ./asserts/entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 5432

VOLUME ["/data/db", "/data/backup"]

ENTRYPOINT /sbin/entrypoint.sh && tail -f /var/log/*
