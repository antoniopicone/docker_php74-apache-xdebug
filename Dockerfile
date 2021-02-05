FROM php:7.4-apache

RUN apt-get update && apt-get install -y wget iputils-ping net-tools

# install xdebug 
RUN cd /tmp \
&& wget https://xdebug.org/files/xdebug-2.8.0.tgz \
&& tar -zxvf xdebug-2.8.0.tgz \
&& cd xdebug-2.8.0 \
&& /usr/local/bin/phpize \
&& ./configure --enable-xdebug --with-php-config=/usr/local/bin/php-config \
&& make \
&& cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/

# add xdebug configurations
RUN echo '[xdebug]' >> /usr/local/etc/php/php.ini
RUN echo 'zend_extension="/usr/local/lib/php/extensions/no-debug-non-zts-20190902/xdebug.so"' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_port=9000' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_host=10.254.254.254' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_enable=1' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_autostart=1' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_connect_back=off' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_handler="dbgp"' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.idekey="VSCODE"' >> /usr/local/etc/php/php.ini
# RUN echo 'xdebug.remote_log="/var/www/html/xdebug.log"' >> /usr/local/etc/php/php.ini


# Installare composer e forse pdo_mysql
RUN \
    docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-install pdo_mysql 

#Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install zip & git
RUN apt-get update && apt-get install -y zip git