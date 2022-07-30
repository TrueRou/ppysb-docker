# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM python:3.9-alpine AS builder

ENV OSU_REPO_URL https://github.com/ppy-sb/bancho.py.git
ENV WEB_REPO_URL https://github.com/ppy-sb/guweb.git
# ENV CODE_SERVER_URL https://github.com/coder/code-server/releases/download/v4.5.1/code-server-4.5.1-linux-amd64.tar.gz

# EXPOSE 8080
EXPOSE 10000

WORKDIR /osu-server
# install depencies
RUN apk update \
    && apk add git \
    && apk add bash \
    && apk add curl \
    && apk add gcompat \
    && apk add gnupg \
    # && apk add nodejs npm \
    && apk add build-base \
    && apk add libffi-dev \
    && apk add linux-headers \ 
    # for `Pillow` in guweb, which needs to be compiled for linux.arm64
    && apk add tiff-dev jpeg-dev openjpeg-dev zlib-dev freetype-dev lcms2-dev \
    libwebp-dev tcl-dev tk-dev harfbuzz-dev fribidi-dev libimagequant-dev \
    libxcb-dev libpng-dev \
    # till....... here!
    && git clone $OSU_REPO_URL \
    && git clone $WEB_REPO_URL

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
# source $HOME/.cargo/env here won't help linux/arm64.

ENV PATH /root/.cargo/bin:$PATH

WORKDIR /osu-server/bancho.py
RUN source $HOME/.cargo/env \
    && git submodule update --init \
    && pip install -U pip setuptools \
    && python3.9 -m pip install -r requirements.txt 
COPY .env /osu-server/bancho.py/
# Just for the pp system of ppysb(we need rust environment)
RUN source $HOME/.cargo/env && bash -c "pip install git+https://github.com/ppy-sb/ppysb-pp-py.git"

WORKDIR /osu-server/guweb
RUN git submodule init && git submodule update \
    && python3.9 -m pip install -r ext/requirements.txt
COPY config.py /osu-server/guweb/

# WORKDIR /
# missing dependency for code-server
# RUN npm install -g node-addon-api

# RUN npm install -g code-server
# RUN wget $CODE_SERVER_URL -O code-server.tar.gz
# RUN mkdir code-server \
#     && tar -zxvf code-server.tar.gz -C /code-server --strip-components 1 \
#     && sed -i 's/"$ROOT\/lib\/node"/node/g'  /code-server/bin/code-server \
#     && rm /code-server/lib/node \
#     && rm /code-server.tar.gz

# RUN code-server --install-extension ms-python.python
# RUN code-server --install-extension lokalise.i18n-ally

# CMD ["bash", "code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
CMD [ "ls", "/osu-server" ]