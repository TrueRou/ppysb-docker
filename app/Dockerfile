# syntax=docker/dockerfile:1.4
FROM --platform=$TARGETPLATFORM python:3.11.5-alpine3.18 AS builder

ENV OSU_REPO_URL https://github.com/ppy-sb/bancho.py.git

WORKDIR /osu-server
# install depencies
RUN apk update \
    && apk add git \
    bash \
    curl \
    gcompat \
    gnupg \
    build-base \
    libffi-dev \
    linux-headers

# rustup
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH /root/.cargo/bin:$PATH

# pre-compile requirements (if needed)
WORKDIR /osu-server
RUN git clone $OSU_REPO_URL

# common libs
RUN python3.11 -m pip install requests
RUN python3.11 -m pip install setuptools

# bancho.py
WORKDIR /osu-server/bancho.py
RUN git submodule update --init \
    && python3.11 -m pip install -r requirements.txt

# bancho.py builder
FROM builder AS bancho.py
COPY --from=builder /usr/local/lib/python3.11/site-packages /usl/local/lib/python3.11/site-packages

WORKDIR /osu-server/bancho.py
COPY .env /osu-server/bancho.py/.env

# Just for the pp system of ppysb (we need rust environment)
RUN bash -c "pip install git+https://github.com/ppy-sb/rosu-pp-py.git"

COPY bancho.py/run-on-start.sh /run-on-start.sh

ENTRYPOINT [ "bash", "/run-on-start.sh" ]
