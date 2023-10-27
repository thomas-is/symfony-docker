#!/bin/sh

git config --global user.name  "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

sed -e "s/user = nobody/user = $FPM_USER/g"   -i /etc/php82/php-fpm.d/www.conf
sed -e "s/group = nobody/group = $FPM_USER/g" -i /etc/php82/php-fpm.d/www.conf
sed -e 's/;clear_env/clear_env/g'             -i /etc/php82/php-fpm.d/www.conf

php-fpm82 --allow-to-run-as-root
#crond -f -l 8 &

exec "$@"
