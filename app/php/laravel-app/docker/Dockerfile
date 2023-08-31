FROM composer as composer
WORKDIR /workspace/app

COPY ./composer.json ./composer.lock ./

RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

RUN --mount=type=cache,id=composer-cache,target=~/.composer/cache,sharing=locked composer install --no-dev --prefer-dist --no-progress --no-suggest --no-scripts --optimize-autoloader \
      && composer clearcache

FROM php:8.1-fpm-alpine as laravel
WORKDIR /workspace/app

COPY --from=composer /workspace/app/vendor/ ./vendor/
COPY . .
# COPY --from=frontend /app/public/js/ ${LARAVEL_PATH}/public/js/
# COPY --from=frontend /app/public/css/ ${LARAVEL_PATH}/public/css/
# COPY --from=frontend /app/public/mix-manifest.json ${LARAVEL_PATH}/public/mix-manifest.json

# RUN   mkdir -p storage \
#       && mkdir -p storage/framework/cache \
#       && mkdir -p storage/framework/sessions \
#       && mkdir -p storage/framework/testing \
#       && mkdir -p storage/framework/views \
#       && mkdir -p storage/logs \
#       && chmod -R 777 storage \
#       && php artisan package:discover

CMD ["php-fpm"]      

# FROM nginx:alpine as nginx
# WORKDIR /workspace/app

# COPY docker/laravel.conf /etc/nginx/conf.d/
# COPY --from=laravel /workspace/app/public /workspace/app/public










