# syntax=docker/dockerfile:1.4
FROM --platform=$TARGETPLATFORM node:18 AS guccho
ENV WEB_REPO_URL https://github.com/ppy-sb/guccho.git

WORKDIR /osu-server
RUN git clone $WEB_REPO_URL

WORKDIR /osu-server/guccho
RUN yarn install
RUN yarn build:schemas

COPY /.env /osu-server/guccho/
COPY /run-on-start.sh /run-on-start.sh

EXPOSE 3000

ENTRYPOINT [ "bash", "/run-on-start.sh" ]