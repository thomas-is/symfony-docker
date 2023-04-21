FROM alpine

ENV FPM_USER  "nginx"
ENV GIT_NAME  "alpine"
ENV GIT_EMAIL "alpine@docker.invalid"

RUN echo "UTC" > /etc/timezone
RUN apk add --no-cache \
  bash \
  ca-certificates \
  curl \
  git \
  nginx \
  php81-cli \
  php81-ctype \
  php81-dom \
  php81-fpm \
  php81-iconv \
  php81-intl \
  php81-opcache \
  php81-pdo \
  php81-pdo_mysql \
  php81-pdo_sqlite \
  php81-phar \
  php81-posix \
  php81-session \
  php81-tokenizer \
  php81-simplexml \
  php81-xml

RUN curl -sS https://get.symfony.com/cli/installer \
  | bash -s -- --install-dir /usr/local/bin

RUN curl -sS https://getcomposer.org/installer \
  | php -- --install-dir /usr/local/bin

RUN git config --global user.name  "$GIT_NAME"
RUN git config --global user.email "$GIT_EMAIL"

COPY ./nginx/default.conf /etc/nginx/http.d/default.conf
RUN mkdir -p /run/nginx/

WORKDIR /srv

RUN mkdir -p /srv/symfony

EXPOSE 80

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;" ]
