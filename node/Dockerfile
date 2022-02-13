# FROM node:lts-alpine

# LABEL maintainer="lalifeier <lalifeier@gmail.com>"

# ENV TIME_ZONE=Asia/Shanghai
# RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

# RUN npm install -g pnpm

# RUN pnpm config set registry https://registry.npmmirror.com

# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash


FROM alpine:latest

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

ENV NODE_VERSION --lts

RUN apk update && \
    apk add --no-cache curl bash ca-certificates openssl ncurses coreutils python2 make gcc g++ libgcc linux-headers grep util-linux binutils findutils

SHELL [ "/bin/bash", "-c" ]

# curl -o- https://raw.fastgit.org/nvm-sh/nvm/v0.39.1/install.sh | bash && \

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
    echo -e 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"\n[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' > $HOME/.bashrc && \
    source $HOME/.bashrc && \
    nvm install -s $NODE_VERSION && \
    nvm use $NODE_VERSION && \
    node -v && npm -v && \
    npm install -g nrm && \
    nrm use taobao && \
    npm install -g yarn pnpm && \
    nvm cache clear

ENTRYPOINT [ "/bin/bash" ]
