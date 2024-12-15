# syntax=docker/dockerfile:1.4
FROM --platform=$TARGETPLATFORM python:3.11.5-alpine3.18
ENV OSU_REPO_URL=https://github.com/ppy-sb/bancho.py.git

# override bancho.py default env settings
ENV DOMAIN=dev.ppy.sb
ENV DB_USER=root
ENV DB_PASS=
# DEVELOPER_MODE and DEBUG will be set to False in PROD_MODE
ENV DEVELOPER_MODE=True
ENV DEBUG=True
ENV DISALLOW_INGAME_REGISTRATION=False

# install depencies and rustup
RUN apk update \
    && apk add git \
    bash \
    curl \
    gcompat \
    gnupg \
    build-base \
    libffi-dev \
    linux-headers
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH /root/.cargo/bin:$PATH

# pre-compile requirements (if needed)
WORKDIR /osu-server
RUN git clone $OSU_REPO_URL
RUN python3.11 -m pip install requests
RUN python3.11 -m pip install setuptools
RUN python3.11 -m pip install poetry

# bancho.py
WORKDIR /osu-server/bancho.py
RUN git submodule update --init \
    && poetry config virtualenvs.create false \
    && poetry install --no-root

RUN cp .env.example .env
RUN cp logging.yaml.example logging.yaml
COPY run-on-start.sh /run-on-start.sh

ENTRYPOINT [ "bash", "/run-on-start.sh" ]