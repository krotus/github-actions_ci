FROM php:8.3-fpm-alpine
WORKDIR /app

RUN apk --update upgrade \
    && apk add --no-cache autoconf automake make gcc g++ icu-dev rabbitmq-c rabbitmq-c-dev linux-headers parallel \
    && pecl install amqp-2.1.2 \
    && pecl install apcu-5.1.23 \
    && pecl install xdebug-3.3.2 \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        opcache \
        intl \
        pdo_mysql \
        pcntl \
    && docker-php-ext-enable \
        amqp \
        apcu \
        opcache

COPY etc/infrastructure/php/ /usr/local/etc/php/