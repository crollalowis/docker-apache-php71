FROM php:7.3-apache

COPY config/php.ini /usr/local/etc/php/

# Dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  libsqlite3-dev \
  libzip-dev \
  libjpeg-dev \
  libpng-dev \
  libmcrypt-dev \
  libmagickwand-dev \
  sudo \
  git \
  zip

RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr
RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install exif
RUN docker-php-ext-install intl
RUN docker-php-ext-install mysqli pdo_mysql pdo_sqlite
RUN rm -rf /var/lib/apt/lists/*

# PECL
RUN pecl install imagick \
  && pecl install mcrypt \
  && docker-php-ext-enable mcrypt \
  && docker-php-ext-enable imagick

# Composer & Craft CLI
RUN curl --silent --show-error https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer \
  && composer global require craft-cli/cli


# add user with sudo

# RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
# USER docker

#&& composer create-project craftcms/craft /var/www/html/

ENV PATH "$PATH:~/.composer/vendor/bin:/usr/local/bin"

# Go
RUN curl --insecure -O https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz \
  && tar -xvf go1.9.linux-amd64.tar.gz \
  && mv go /usr/local \
  && cp /usr/local/go/bin/go /usr/local/bin

# Mhsendmail
RUN go get github.com/mailhog/mhsendmail \
  && cp /root/go/bin/mhsendmail /usr/bin/mhsendmail

# Apache Extensions
RUN a2enmod headers rewrite expires deflate


# Entrypoint
COPY bootstrap/entry.sh /usr/local/bin/entry
RUN chmod +x /usr/local/bin/entry

# change owner of web-root
RUN chown www-data:www-data /var/www

# we are currently running around as root
# USER www-data

ENTRYPOINT ["/usr/local/bin/entry"]
