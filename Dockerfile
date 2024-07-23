FROM php:8.2-fpm

# Install necessary packages including Nginx and Composer dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    git \
    unzip \
    curl \
    && apt-get clean

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy your application code
COPY . /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Make the setup script executable
RUN chmod +x 00-laravel-deploy.sh

# Run the setup script
RUN ./00-laravel-deploy.sh

# Expose port 80
EXPOSE 80

# Copy custom Nginx configuration
COPY conf/nginx/nginx-site.conf /etc/nginx/sites-available/default

# Start Nginx and PHP-FPM
CMD service nginx start && php-fpm
