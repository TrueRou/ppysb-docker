# syntax=docker/dockerfile:1.4
FROM --platform=$TARGETPLATFORM node:16 AS guweb-next
ENV WEB_REPO_URL https://github.com/ppy-sb/guweb-next.git

WORKDIR /osu-server
RUN git clone $WEB_REPO_URL

WORKDIR /osu-server/guweb-next
RUN yarn install
RUN yarn prisma generate

COPY /.env /osu-server/guweb-next/
COPY /run-on-start.sh /run-on-start.sh

EXPOSE 3000

CMD bash /run-on-start.sh
