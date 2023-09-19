# syntax=docker/dockerfile:1.4
FROM --platform=$TARGETPLATFORM python:3.11.5-alpine3.18 AS builder

ENV OSU_REPO_URL https://github.com/ppy-sb/bancho.py.git
ENV WEB_REPO_URL https://github.com/ppy-sb/guweb.git

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
RUN git clone $WEB_REPO_URL

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

# Just for the pp system of ppysb(we need rust environment)
RUN bash -c "pip install git+https://github.com/ppy-sb/ppysb-pp-py.git"

COPY bancho.py/run-on-start.sh /run-on-start.sh

ENTRYPOINT [ "bash", "/run-on-start.sh" ]

# guweb builder
FROM builder AS guweb
ARG TARGETPLATFORM
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

RUN apk add nodejs yarn npm

# for `Pillow` in guweb, which needs to be compiled for linux/arm64
RUN if [ "$TARGETPLATFORM" == "linux/arm64" ];\
    then apk add tiff-dev jpeg-dev openjpeg-dev zlib-dev freetype-dev lcms2-dev \
    libwebp-dev tcl-dev tk-dev harfbuzz-dev fribidi-dev libimagequant-dev \
    libxcb-dev libpng-dev;\
    fi
# till....... here!

WORKDIR /osu-server/guweb

RUN git submodule init && git submodule update \
    && python3.11 -m pip install -r ext/requirements.txt
RUN yarn install --dev
# RUN cp config.sample.js config.js
COPY guweb/config.py /osu-server/guweb/config.py
COPY guweb/config.js /osu-server/guweb/config.js
COPY guweb/run-on-start.sh /run-on-start.sh

EXPOSE 10000

ENTRYPOINT [ "bash", "/run-on-start.sh" ]
