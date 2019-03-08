FROM php:7.2-apache

# Install dependencies
RUN apt-get update \
	&& apt-get install -y \
	libpng-dev \
	ldap-utils openssl libldap2-dev unzip zlib1g-dev libicu-dev g++ libgd3 libgd-dev vim wget runit git\
	&& rm -rf /var/lib/apt/lists/*

# Install PHP dependecies in another layer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
    && docker-php-ext-install zip ldap pdo_mysql exif intl \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd

#
# Install Mysql
#
RUN apt-get update && apt-get install -y mysql-server \
	&& rm -rf /var/lib/apt/lists/* \
	&& sed -i -e "s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Configure apache
# - Document Root
# - apache permissions
ENV APACHE_DOCUMENT_ROOT /www-data
RUN mkdir -p $APACHE_DOCUMENT_ROOT \
    && chown -R www-data:www-data $APACHE_DOCUMENT_ROOT \
    && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf \
    && sed -ri -e '/.*CustomLog.*/a  \\tLimitRequestFieldSize 32768'  /etc/apache2/sites-available/*.conf

#
# Install runit services and scripts
#
COPY assets/services /etc/service
COPY assets/script/refresh_www_data /usr/local/bin/refresh_www_data
RUN chmod +x /etc/service/mysql/run \
    && chmod +x /etc/service/mysql/log/run \
    && chmod +x /usr/local/bin/refresh_www_data

ENV TERM=linux

WORKDIR /data

EXPOSE 80 3306

#
# Install Image scripts
#
COPY assets/entrypoint.sh /opt/devspaces/entrypoint.sh
RUN chmod +x /opt/devspaces/entrypoint.sh

ENTRYPOINT /opt/devspaces/entrypoint.sh
