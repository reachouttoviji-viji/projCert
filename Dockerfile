FROM devopsedu/webapp:latest
COPY ./website/ /var/www/html/
EXPOSE 80
CMD ["usr/sbin/apache2ctl", "-D", "FOREGROUND"]