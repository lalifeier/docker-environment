FROM php:8.1-fpm-alpine

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# install-php-extensions
# RUN curl -sSLf \
#         -o /usr/local/bin/install-php-extensions \
#         https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
#     chmod +x /usr/local/bin/install-php-extensions && \
#     install-php-extensions gd pdo_mysql redis xdebug

# composer
RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

RUN apk update && apk add tzdata openssh nginx

ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config &&\
    ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key &&\
    ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key &&\
    ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key &&\
    ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key &&\
    echo "root:123456" | chpasswd

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /data/entrypoint.sh

WORKDIR /data/web/

EXPOSE 22
EXPOSE 80
EXPOSE 443
EXPOSE 9000

CMD ["sh","/data/entrypoint.sh"]
