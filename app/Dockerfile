# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM python:3.9-alpine AS builder

ENV OSU_REPO_URL https://github.com/ppy-sb/bancho.py.git
ENV WEB_REPO_URL https://github.com/ppy-sb/guweb.git

WORKDIR /osu-server
# install depencies
RUN apk update \
    && apk add git \
    && apk add bash \
    && apk add curl \
    && apk add gcompat \
    && apk add gnupg \
    && apk add nodejs yarn \
    && apk add build-base \
    && apk add libffi-dev \
    && apk add linux-headers

# rustup
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH /root/.cargo/bin:$PATH

# RUN code-server --install-extension lokalise.i18n-ally

# pre-compile requirements (if needed)
WORKDIR /osu-server
RUN git clone $OSU_REPO_URL
RUN git clone $WEB_REPO_URL

## guweb
# WORKDIR /osu-server/guweb
# RUN git submodule init && git submodule update \
#     && python3.9 -m pip install -r ext/requirements.txt

## bancho.py
WORKDIR /osu-server/bancho.py
RUN git submodule update --init \
    && pip install -U pip setuptools \
    && python3.9 -m pip install -r requirements.txt


FROM builder AS bancho.py
COPY --from=builder /usr/local/lib/python3.9/site-packages /usl/local/lib/python3.9/site-packages

WORKDIR /osu-server/bancho.py
# RUN git submodule update --init \
#     && pip install -U pip setuptools \
#     && python3.9 -m pip install -r requirements.txt 
COPY .env /osu-server/bancho.py/

# Just for the pp system of ppysb(we need rust environment)
RUN bash -c "pip install git+https://github.com/ppy-sb/ppysb-pp-py.git"

COPY bancho.py/run-on-start.sh /run-on-start.sh

EXPOSE 8080
ENTRYPOINT [ "bash", "/run-on-start.sh" ]


FROM builder AS guweb
COPY --from=builder /usr/local/lib/python3.9/site-packages /usl/local/lib/python3.9/site-packages
# for `Pillow` in guweb, which needs to be compiled for linux/arm64
RUN apk add tiff-dev jpeg-dev openjpeg-dev zlib-dev freetype-dev lcms2-dev \
    libwebp-dev tcl-dev tk-dev harfbuzz-dev fribidi-dev libimagequant-dev \
    libxcb-dev libpng-dev
    # till....... here!
WORKDIR /osu-server/guweb
RUN git submodule init && git submodule update \
    && python3.9 -m pip install -r ext/requirements.txt
RUN python3.9 -m pip install requests 
RUN yarn install --dev && yarn i18n:compile
COPY config.py /osu-server/guweb/

COPY guweb/run-on-start.sh /run-on-start.sh
EXPOSE 8080
EXPOSE 10000
ENTRYPOINT [ "bash", "/run-on-start.sh" ]
