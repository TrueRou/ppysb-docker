# syntax=docker/dockerfile:1.4
FROM --platform=$TARGETPLATFORM node:lts AS guccho
ENV WEB_REPO_URL https://github.com/ppy-sb/guccho.git
ARG build_guccho

RUN npm install -g pnpm

# WORKDIR /osu-server
WORKDIR /
RUN git clone $WEB_REPO_URL guccho

WORKDIR /guccho
RUN git checkout docker
# RUN sort -u -t '=' -k 1,1 .env.example .env | grep -v '^$\|^\s*\#' > .env

COPY /.env /guccho/.env
COPY /guccho.* /guccho/
# RUN cp /guccho/docker/.env.example /guccho/.env

RUN pnpm install 
RUN if [ "${build_guccho}" != "true" ]; then pnpm build; fi;

COPY /run-on-start.sh /run-on-start.sh

EXPOSE 3000

ENTRYPOINT [ "bash", "/run-on-start.sh" ]
