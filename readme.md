# Docker image for with Apache and PHP7.1

Prepared to use with Craft CMS

This image installs all assets that are required by Craft CMS.

---

Download:

> docker pull crollalowis/docker-apache-php71


---

## Dependencies:

Base Image:

- php:7.1-apache


### PHP 7.1

- gd 

- zip

- exif

- mbstring

- mcrypt

- mysqli

- pdo

- pdo_mysql

- imagick

### Composer

- [Craft CLI](https://github.com/rsanchez/craft-cli)

### Go 1.9

- mailhog

### MySQL Client