FROM php:7.2.3-fpm

LABEL maintainer=scofieldpeng
# change source to aliyun mirror for fucking gfw
COPY ./sources.list /etc/apt/sources.list

# install gd,iconv,mcrypt,pdo_mysql
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql
# install redis    
RUN pecl install redis && docker-php-ext-enable redis
# install memcached
RUN apt-get install -y libmemcached-dev && pecl install memcached && docker-php-ext-enable memcached