FROM php:5.6-cli RUN mkdir /app RUN mkdir /build
#Installing Dependencies
RUN apt-get update && \
    apt-get install git libssl-dev zip -y
ARG PECL_EXTENSIONS='mongo,mysql'
#Installing And setting up composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /bin/composer
#Installing PHP Extensions
RUN pecl install $(echo $PECL_EXTENSIONS | tr ',' ' ') && \
    docker-php-ext-enable $(echo $PECL_EXTENSIONS | tr ',' ' ')
#Installing and setting up Symfony2
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony RUN chmod a+x /usr/local/bin/symfony

ARG TIMEZONE='date.timezone="Europe/Lisbon"'
RUN echo $TIMEZONE >> /usr/local/etc/php/php.ini
