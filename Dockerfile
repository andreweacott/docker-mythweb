FROM php:8.2-apache

RUN a2enmod rewrite
RUN a2enmod env
RUN a2enmod deflate
RUN a2enmod headers

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

LABEL maintainer="Andrew Eacott <andrew@marmoset.org>"

RUN apt-get update && apt-get install -y git

ARG REPO_URL=https://github.com/MythTV/mythweb.git
ARG REPO_TAG=v34.0
RUN git clone --branch ${REPO_TAG} --depth 1 ${REPO_URL} .

ENV MYTHTV_BRANCH=fixes/34
ENV MYTHTV_SCM_BASE=https://raw.githubusercontent.com/MythTV/mythtv/${MYTHTV_BRANCH}

RUN mkdir -p /var/www/html/classes && \
    curl -sSL ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythBackend.php -o /var/www/html/classes/MythBackend.php && \
    curl -sSL ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythBase.php -o /var/www/html/classes/MythBase.php && \
    curl -sSL ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythFrontend.php -o /var/www/html/classes/MythFrontend.php && \
    curl -sSL ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythTV.php -o /var/www/html/classes/MythTV.php && \
    curl -sSL ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythTVChannel.php -o /var/www/html/classes/MythTVChannel.php && \
    curl -sSL ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythTVProgram.php -o /var/www/html/classes/MythTVProgram.php && \
    curl -sSL ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythTVRecording.php -o /var/www/html/classes/MythTVRecording.php && \
    curl -sSL ${MYTHTV_SCM_BASE}/mythtv/bindings/php/MythTVStorageGroup.php -o /var/www/html/classes/MythTVStorageGroup.php && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

COPY mythweb.conf /etc/apache2/sites-enabled/
