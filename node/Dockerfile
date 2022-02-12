# FROM node:lts-alpine

# LABEL maintainer="lalifeier <lalifeier@gmail.com>"

# ENV TIME_ZONE=Asia/Shanghai
# RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

# RUN npm install -g pnpm

# RUN pnpm config set registry https://registry.npmmirror.com

# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


FROM alpine:latest

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

ENV NODE_VERSION --lts

RUN apk update && \
    apk add --no-cache curl bash ca-certificates openssl ncurses coreutils python2 make gcc g++ libgcc linux-headers grep util-linux binutils findutils && \
    # touch ~/.bashrc && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
    # export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    source ~/.bashrc && \
    nvm install -s $NODE_VERSION && \
    nvm use $NODE_VERSION && \
    node -v && npm -v && \
    npm install -g nrm yarn pnpm && \
    nrm use taobao && \
    nvm cache clear
