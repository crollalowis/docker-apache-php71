FROM php:7.1-apache

COPY config/php.ini /usr/local/etc/php/

# Dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-mysql-client \
    libjpeg-dev \
    libpng-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    sudo \
    git \
    zip \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd \
  && docker-php-ext-install zip \
  && docker-php-ext-install exif \
  && docker-php-ext-install intl \
  && docker-php-ext-install mbstring \
  && docker-php-ext-install mcrypt \
  && docker-php-ext-install mysqli pdo pdo_mysql \
  && rm -rf /var/lib/apt/lists/*


RUN echo "Europe/Berlin" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
ENV TZ='Europe/Berlin'

# Imagick
RUN pecl install imagick \
  && docker-php-ext-enable imagick

# Composer & Craft CLI
RUN curl --silent --show-error https://getcomposer.org/installer | php \
  && chmod +x composer.phar \
  && mv composer.phar /usr/local/bin/composer \
  && composer global require hirak/prestissimo

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
RUN a2enmod headers rewrite expires deflate proxy_http


# Entrypoint
COPY bootstrap/entry.sh /usr/local/bin/entry
RUN chmod +x /usr/local/bin/entry

# change owner of web-root
RUN chown www-data:www-data /var/www

# we are currently running around as root
# USER www-data

ENTRYPOINT ["/usr/local/bin/entry"]
