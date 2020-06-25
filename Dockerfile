FROM php:7.2.31-fpm

LABEL maintainer=cocakuma

# install gd,iconv,mcrypt,pdo_mysql,zip
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        zip \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip