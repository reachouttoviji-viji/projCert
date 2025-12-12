FROM devopsedu/webapp:latest
COPY website/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html
EXPOSE 80
CMD ["usr/sbin/apache2ctl", "-D", "FOREGROUND"]