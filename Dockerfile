FROM starcitizentools/mediawiki:latest

USER root

RUN docker-php-ext-configure pcntl --enable-pcntl \
  && docker-php-ext-install pcntl

WORKDIR /var/www/html

USER www-data

RUN git clone https://github.com/wikimedia/mediawiki-services-jobrunner.git

RUN mv /var/www/provisioning/ /var/www/mediawiki

COPY --chown=www-data:www-data ./jobrunner-conf.json /var/www/html/mediawiki-services-jobrunner

ENTRYPOINT ["/usr/local/bin/php", "/var/www/html/mediawiki-services-jobrunner/redisJobRunnerService", "--config-file=/var/www/html/mediawiki-services-jobrunner/jobrunner-conf.json"]
