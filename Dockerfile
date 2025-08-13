# Gunakan PHP 8.2 FPM
FROM php:8.2-fpm

# Install dependencies sistem
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libpq-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-install intl pdo pdo_mysql bcmath zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy semua file project
COPY . .

# Install dependencies Laravel
RUN composer install --no-dev --optimize-autoloader

# Set permission untuk storage & bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

# Expose port
EXPOSE 9000

CMD ["php-fpm"]
