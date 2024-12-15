# syntax=docker/dockerfile:1.4
FROM --platform=$TARGETPLATFORM node:23
ENV WEB_REPO_URL https://github.com/ppy-sb/Guccho.git
ENV DB_DSN=mysql://root:@mysql:3306/banchopy
ENV REDIS_URL=redis://redis:6379
ENV HOST=0.0.0.0
ENV PORT=3000

# # pre-compile requirements
WORKDIR /osu-server
RUN git clone $WEB_REPO_URL
RUN npm install -g pnpm

# guccho
WORKDIR /osu-server/Guccho
RUN cp .env.example .env
RUN cp guccho.ui.config.example.ts guccho.ui.config.ts
RUN cp guccho.backend.config.example.ts guccho.backend.config.ts
RUN pnpm install

COPY /run-on-start.sh /run-on-start.sh
RUN mkdir -p /osu-server/Guccho/.dump/ppy.sb/avatar

ENTRYPOINT [ "bash", "/run-on-start.sh" ]