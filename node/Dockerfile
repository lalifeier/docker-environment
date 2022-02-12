FROM node:lts-alpine

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

RUN npm install -g pnpm

RUN pnpm config set registry https://registry.npmmirror.com
