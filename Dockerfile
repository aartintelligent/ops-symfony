FROM aartintelligent/php:8.3-composer AS composer

COPY . /var/www

WORKDIR /var/www

RUN set -eux; \
    composer install \
        --prefer-dist \
        --no-autoloader \
        --no-interaction \
        --no-scripts \
        --no-progress \
        --no-dev; \
    composer dump-autoload \
        --optimize

FROM node:lts-bookworm AS webpack

COPY . /var/www

COPY --chown=rootless:rootless --from=composer /var/www/vendor /var/www/vendor

WORKDIR /var/www

RUN npm install && npm run build

FROM aartintelligent/php:8.3-nginx AS webapp

USER root

COPY --chown=rootless:rootless . /var/www

COPY --chown=rootless:rootless --from=composer /var/www/vendor /var/www/vendor

COPY --chown=rootless:rootless --from=webpack /var/www/public/build /var/www/public/build

USER rootless
