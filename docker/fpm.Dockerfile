FROM ubuntu:focal

# Set the WORKDIR for this container
WORKDIR /var/www/mail.gnuweeb.org

# Tell apt that DEBIAN_FRONTEND is noninteractive
ARG DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update \
    && apt-get -y --no-install-recommends install software-properties-common ca-certificates \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        php8.1 php8.1-fpm php8.1-common php8.1-cli \
        php8.1-bcmath php8.1-bz2 php8.1-cgi php8.1-curl php8.1-dba php8.1-dev php8.1-enchant php8.1-gd php8.1-opcache \
        php8.1-gmp php8.1-imap php8.1-interbase php8.1-intl php8.1-ldap php8.1-mbstring php8.1-mysql php8.1-readline php8.1-snmp \
        php8.1-soap php8.1-sybase php8.1-tidy php8.1-xml php8.1-xmlrpc php8.1-xsl php8.1-zip libphp8.1-embed \
    && apt-get purge -y software-properties-common \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# Make php-fpm listen on port 9000
RUN sed -i 's/\/run\/php\/php[0-9].[0-9]-fpm.sock/9000/' /etc/php/8.1/fpm/pool.d/www.conf \
    # Fix php-fpm can't create PID file
    && mkdir /run/php \
    && chmod 755 /run/php \
    # Don't clear environment variables
    && sed -i 's/\;clear_env/clear_env/' /etc/php/8.1/fpm/pool.d/www.conf

# Tell that port 9000 is available to be exposed
EXPOSE 9000

# Redirect php-fpm log to Container's STDOUT
RUN ln -sf /proc/self/fd/2 /var/log/php8.1-fpm.log

# Copy mail.gnuweeb.org files
COPY . .

# Run php-fpm
CMD ["php-fpm8.1", "--nodaemonize", "--fpm-config", "/etc/php/8.1/fpm/php-fpm.conf"]
