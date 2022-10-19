# syntax=docker/dockerfile:1.4
FROM --platform=$TARGETPLATFORM python:3.9-alpine AS bancho.py
ENV OSU_REPO_URL https://github.com/ppy-sb/bancho.py.git

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
RUN python3.9 -m pip install requests
RUN python3.9 -m pip install setuptools

# bancho.py requirements
WORKDIR /osu-server/bancho.py
RUN git submodule update --init \
    && python3.9 -m pip install -r requirements.txt
RUN bash -c "pip install git+https://github.com/ppy-sb/ppysb-pp-py.git"


WORKDIR /osu-server/bancho.py
COPY /bancho.py/.env /osu-server/bancho.py/
COPY bancho.py/run-on-start.sh /run-on-start.sh

ENTRYPOINT [ "bash", "/run-on-start.sh" ]

# guweb-next

FROM --platform=$TARGETPLATFORM alpine AS guweb-next
ENV WEB_REPO_URL https://github.com/ppy-sb/guweb-next.git

RUN apk update \
    && apk add git nodejs yarn npm

WORKDIR /osu-server
RUN git clone $WEB_REPO_URL

WORKDIR /osu-server/guweb-next
RUN yarn install

COPY /guweb-next/.env /osu-server/guweb-next/
COPY guweb-next/run-on-start.sh /run-on-start.sh

EXPOSE 3000

ENTRYPOINT [ "bash", "/run-on-start.sh" ]
