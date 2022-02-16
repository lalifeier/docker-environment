# FROM python:latest
FROM python:3.9-slim-bullseye

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list && \
    sed -i 's/security-cdn.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends && \
    apt-get install -y make gosu && \
    rm -rf /var/lib/apt/lists/* && \
    # verify that the binary works
    gosu nobody true

# ARG user=python
# RUN useradd -ms /bin/bash $user

# USER $user
# ENV PATH="/home/${user}/.local/bin:${PATH}"

# RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
# 	&& pip config set install.trusted-host mirrors.aliyun.com \
#   && pip install --upgrade pip && pip install --user pipenv

ENV PIP_REQUIRE_VIRTUALENV=true

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash"]
