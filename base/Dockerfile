FROM debian
MAINTAINER Pablo Leonardo Mendes da Cruz Lima, pabloleomendes@gmail.com

RUN apt-get update && apt-get install -y aptitude
RUN apt-get install -y vim \
        telnet \
        wget \
        curl \
	sudo \
        net-tools \
		make \
		gcc \
		tar \
		libreadline6-dev \
		zlib1g-dev

ENV pginst /usr/local/src/postgresql-9.6.2
#ADD https://ftp.postgresql.org/pub/source/v9.6.2/postgresql-9.6.2.tar.gz /usr/local/src
COPY ./asserts/postgresql-9.6.2.tar.gz /usr/local/src
WORKDIR /usr/local/src
RUN tar -zxf /usr/local/src/postgresql-9.6.2.tar.gz
WORKDIR ${pginst}
RUN ./configure --prefix=/usr/local/pgsql9.6.2
RUN make && make install && ln -s /usr/local/pgsql9.6.2 /usr/local/pgsql && useradd --password teste123 --create-home --create-home --user-group --shell /bin/bash postgres
#RUN mkdir -p /data/db
#RUN chown -R postgres /data/db
USER postgres
RUN echo 'PATH=$PATH:/usr/local/pgsql/bin' >> /home/postgres/.bashrc && echo 'PGDATA=/data/db/' >> /home/postgres/.bashrc && echo 'export PATH PGDATA' >> /home/postgres/.bashrc
#RUN /usr/local/pgsql/bin/initdb -D /data/db
#RUN echo 'Hello' >> /data/db/teste.txt
USER root
COPY ./asserts/postgresql /etc/init.d/postgresql
RUN chmod +x /etc/init.d/postgresql