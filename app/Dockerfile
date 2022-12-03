# syntax=docker/dockerfile:1.4
FROM --platform=$TARGETPLATFORM nixos/nix AS builder

ENV OSU_REPO_URL https://github.com/ppy-sb/bancho.py.git
ENV WEB_REPO_URL https://github.com/ppy-sb/guweb.git


# install depencies
ARG nix_use_mirror="false" 
ARG nix_mirror="https://mirrors.bfsu.edu.cn/nix-channels/nixpkgs-unstable"
ARG nix_substituters="https://mirrors.bfsu.edu.cn/nix-channels/store https://nix-bin.hydro.ac/"

RUN if [ "$nix_use_mirror" = "true" ]; \
    then nix-channel --remove nixpkgs && nix-channel --add $nix_mirror nixpkgs; \
    fi
RUN nix-channel --update
RUN if [ "$nix_use_mirror" = "true" ]; \
    then echo "substituters = ${nix_substituters} https://cache.nixos.org/" >/etc/nix/nix.conf; \
    else echo "substituters = https://cache.nixos.org/" >/etc/nix/nix.conf;\
    fi
RUN echo "connect-timeout = 10" >>/etc/nix/nix.conf \
    && nix-env -iA nixpkgs.git nixpkgs.curl nixpkgs.bash nixpkgs.gnupg nixpkgs.gcc \
    nixpkgs.python3 nixpkgs.python3Packages.setuptools nixpkgs.python3Packages.pip 
WORKDIR /osu-server
RUN git clone $OSU_REPO_URL --recursive
RUN git clone $WEB_REPO_URL --recursive

WORKDIR /osu-server/bancho.py
RUN pip install -r requirements.txt


FROM builder AS bancho.py

WORKDIR /osu-server/bancho.py
RUN nix-shell -p rustc cargo --command "pip install git+https://github.com/ppy-sb/ppysb-pp-py.git;exit"

COPY .env /osu-server/bancho.py/
COPY bancho.py/run-on-start.sh /run-on-start.sh

ENTRYPOINT [ "bash", "/run-on-start.sh" ]


FROM builder AS guweb
ARG TARGETPLATFORM

WORKDIR /osu-server/guweb
# RUN nix-env -iA nixpkgs.nodejs nixpkgs.yarn
# RUN pip install -r ext/requirements.txt
# RUN yarn install --dev
# RUN cp config.sample.js config.js && yarn i18n:build

COPY config.py /osu-server/guweb/
COPY guweb/run-on-start.sh /run-on-start.sh


EXPOSE 10000
ENTRYPOINT [ "bash", "/run-on-start.sh" ]
