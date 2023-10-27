FROM alpine

ENV FPM_USER  "nginx"
ENV GIT_NAME  "alpine"
ENV GIT_EMAIL "alpine@docker.invalid"

RUN echo "UTC" > /etc/timezone \
  && apk add --no-cache \
  bash \
  ca-certificates \
  curl \
  git \
  nginx \
  php82-cli \
  php82-ctype \
  php82-dom \
  php82-fpm \
  php82-iconv \
  php82-intl \
  php82-opcache \
  php82-pdo \
  php82-pdo_mysql \
  php82-pdo_sqlite \
  php82-phar \
  php82-posix \
  php82-session \
  php82-tokenizer \
  php82-simplexml \
  php82-xml

RUN ln -s /usr/bin/php82 /usr/bin/php

RUN curl -sS https://getcomposer.org/installer \
  | php -- --install-dir /usr/local/bin \
  && curl -sS https://get.symfony.com/cli/installer \
  | bash -s -- --install-dir /usr/local/bin

COPY ./nginx/default.conf /etc/nginx/http.d/default.conf

WORKDIR /srv

EXPOSE 80

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;" ]
