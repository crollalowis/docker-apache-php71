# Docker image for Craft CMS

This image installs all assets that are required by Craft CMS.
In addition, it automatically downloads Craft CMS by using Craft CLI.

---

Download:

> docker pull burnett01/docker-craftcms


Compose:

Check [CraftCMS-Acme](https://gitlab.com/Burnett01/craftcms-acme) for a boilerplate.

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