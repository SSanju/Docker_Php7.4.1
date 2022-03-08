FROM php:7.4.1-apache

USER root

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        libpq-dev \
        libonig-dev \
        zip \
        xvfb \
        curl \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --enable-gd \
    && docker-php-ext-install gd \
    && docker-php-ext-install sysvsem \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-source delete

RUN docker-php-ext-install pdo pdo_pgsql
RUN apt-get install nano -y
RUN apt install libxrender-dev libxrender1 libfontconfig1 -y

COPY vhost.conf /etc/apache2/sites-available/000-default.conf
COPY index.html /var/www/html/index.html

# Configuration File settings
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN sed -i -e 's/upload_max_filesize = 2M/upload_max_filesize=20M/' /usr/local/etc/php/php.ini-development
RUN sed -i -e 's/upload_max_filesize = 2M/upload_max_filesize=20M/' /usr/local/etc/php/php.ini-production
RUN sed -i -e 's/post_max_size = 8M/post_max_size=120M/' /usr/local/etc/php/php.ini-development
RUN sed -i -e 's/post_max_size = 8M/post_max_size=120M/' /usr/local/etc/php/php.ini-production

# Loaded Configuration File
RUN cat /usr/local/etc/php/php.ini-production >> /usr/local/etc/php/php.ini

RUN chown -R root:www-data /var/www/html \
    && a2enmod rewrite
# Script permission
# Expose port 9000 and start php-fpm server

EXPOSE 9000
CMD ["apache2-foreground"]
