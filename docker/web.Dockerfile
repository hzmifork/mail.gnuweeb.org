FROM nginx:alpine

# Set the WORKDIR for this container
WORKDIR /var/www/mail.gnuweeb.org

# Copy mail.gnuweeb.org files
COPY . .

# Configure nginx
RUN ln -sf /var/www/mail.gnuweeb.org/nginx/fastcgi.conf /etc/nginx \
    && ln -sf /var/www/mail.gnuweeb.org/nginx/snippets /etc/nginx \
    && rm -rf /etc/nginx/conf.d \
    && ln -sf /var/www/mail.gnuweeb.org/nginx/conf.d /etc/nginx/
