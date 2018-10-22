FROM php:7.2-apache

Maintainer Camilo Casadiego <camilo.casadiego@aurea.com>

ENV APACHE_DOCUMENT_ROOT /app

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 

RUN apt-get update \
	&& apt-get install -y \
	libpng-dev \
	ldap-utils openssl libldap2-dev unzip zlib1g-dev libicu-dev g++ libgd3 libgd-dev

#We install de dependecies ion another layer
RUN docker-php-ext-install zip ldap pdo_mysql exif intl \
	&& mkdir /app \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd

COPY ./ /app

WORKDIR /app

RUN cd /app  \
	&& chown -R www-data:www-data * \
	&& composer install