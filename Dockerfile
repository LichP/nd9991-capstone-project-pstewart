###
# Base image: PHP, nginx, composer, composer packages, and application
FROM php:8.2-fpm-alpine as base

# Install OS packages
RUN apk add nginx supervisor

# Configure nginx, supervisord, and php-fpm
COPY docker/nginx.conf /etc/nginx/http.d/default.conf
COPY docker/supervisord.conf /etc/supervisord.conf
COPY docker/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Setup working directory
WORKDIR /var/www/html

# Copy in application
COPY . .

# Install composer dependencies
RUN composer install --optimize-autoloader --no-dev

###
# Front-end image: We build this separately from a node image so we can
# compile our front-end assets and then copy the resulting artefacts
# to our final image. This means our final image does not need to include
# node.
FROM node:lts-alpine as frontend

# Setup working directory
WORKDIR /app
RUN mkdir /app/public

# Copy in files required for front-end build
COPY package.json package-lock.json vite.config.js ./
COPY resources/css/ ./resources/css/
COPY resources/js/ ./resources/js/

# Install node dependencies and build
RUN npm install
RUN npm run build

###
# Final image
FROM base

# Setup working directory
WORKDIR /var/www/html

# Copy in front-end build artefacts
COPY --from=frontend /app/public/build/ ./public/build/

# Run Laravel deployment optimizations except config cache (see https://laravel.com/docs/10.x/deployment)
# We omit config caching during the so that we're able to inject config into the running environment with
# relevant runtime secrets. We then perform the config:cache at run time immediately prior to starting
# php-fpm (see supervisord.conf)
RUN php artisan event:cache && \
    php artisan route:cache && \
    php artisan view:cache

# Set ownership of files which should be web modifiable
RUN chown -R www-data:www-data bootstrap/cache storage

# Expose port 80 served by nginx
EXPOSE 80

# Run supervisord
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
