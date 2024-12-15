# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM mysql:8.0.32
ENV MYSQL_ALLOW_EMPTY_PASSWORD yes
EXPOSE 3306

COPY /init/base.sql /mysql/base.sql
COPY /init/prod.sq[l] /mysql/base.sql
COPY /init/init.sql /docker-entrypoint-initdb.d