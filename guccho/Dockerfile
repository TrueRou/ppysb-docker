# syntax=docker/dockerfile:1.4
FROM --platform=$TARGETPLATFORM node:18 AS guccho
ENV WEB_REPO_URL https://github.com/ppy-sb/guccho.git

WORKDIR /osu-server
RUN git clone $WEB_REPO_URL

WORKDIR /osu-server/guccho
RUN sort -u -t '=' -k 1,1 .env.example .env | grep -v '^$\|^\s*\#' > .env

RUN yarn install || true
RUN yarn build:gen

COPY /.env /osu-server/guccho/.env
COPY /run-on-start.sh /run-on-start.sh

EXPOSE 3000

ENTRYPOINT [ "bash", "/run-on-start.sh" ]