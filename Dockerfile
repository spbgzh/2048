FROM ubuntu:14.04

# Install Nginx.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
#VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]
RUN rm -rf /usr/share/nginx/html
RUN mkdir web /usr/share/nginx/html
RUN chmod -R 755 /usr/share/nginx/html
COPY web /usr/share/nginx/html

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443