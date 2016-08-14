FROM debian:jessie

# explicitly set user/group IDs
RUN groupadd -r postgres --gid=999 && useradd -r -g postgres --uid=999 postgres

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
	&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
	&& apt-get purge -y --auto-remove ca-certificates wget

# make the "ru_RU.UTF-8" locale so postgres will be utf-8 enabled by default
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.utf8

RUN mkdir /docker-entrypoint-initdb.d

ENV PG_MAJOR 9.4
# Check with apt-cache policy locate postgresql-9.4
ENV PG_VERSION 9.4.8-1.jessie-1C

RUN set -x \
	&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget \
	&& echo 'deb http://1c.postgrespro.ru/deb/ jessie main' > /etc/apt/sources.list.d/postgrespro-1c.list \
	&& wget --quiet -O - http://1c.postgrespro.ru/keys/GPG-KEY-POSTGRESPRO-1C-92 | apt-key add - \
	&& apt-get update \
	&& apt-get install -y \
		postgresql-$PG_MAJOR=$PG_VERSION \
		postgresql-contrib-$PG_MAJOR=$PG_VERSION \
	&& apt-get purge -y --auto-remove ca-certificates wget \	
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /

# https://github.com/dalibo/docker
# powa_archivist install
WORKDIR /usr/local/src

RUN apt-get update && apt-get install -y \
		gcc \
		jq \
		make \
		# don't forget to change this line wgetn copy-paster from dalibo github
		postgresql-$PG_MAJOR=$PG_VERSION \
		postgresql-server-dev-$PG_MAJOR \
		wget \
    && wget -O- $(wget -O- https://api.github.com/repos/dalibo/powa-archivist/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/dalibo/pg_qualstats/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/dalibo/pg_stat_kcache/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/dalibo/hypopg/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/rjuju/pg_track_settings/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && for f in $(ls); do cd $f; make install; cd ..; rm -rf $f; done \
    && apt-get purge -y --auto-remove gcc jq make postgresql-server-dev-$PG_MAJOR wget \
    && rm -rf /var/lib/apt/lists/*

# configure powa-archivist
ADD 01-setup_powa-archivist.sh /docker-entrypoint-initdb.d/
ADD enable_powa.sql /usr/local/src/

ADD 02-tune.sh /docker-entrypoint-initdb.d/
ADD postgresql.conf /usr/local/src/

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]