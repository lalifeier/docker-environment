# FROM python:latest
FROM python:3.9-slim-bullseye

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

# RUN apt-get update && apt-get install -y --no-install-recommends

RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
	&& pip config set install.trusted-host mirrors.aliyun.com \
  && pip install pipenv
