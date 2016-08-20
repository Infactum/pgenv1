FROM nginx:stable-alpine

ENV PGBVERSION=8.2

RUN set -x \ 
    && apk --no-cache add build-base curl perl \    
    && curl -L https://github.com/dalibo/pgbadger/archive/v$PGBVERSION.tar.gz | tar xz \
    && cd pgbadger-$PGBVERSION \
    && perl Makefile.PL && make && make install \
    && cd .. \
    && rm -rf pgbadger-$PGBVERSION \
    && apk del build-base curl

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]


 