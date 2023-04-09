FROM ubuntu:latest
RUN apt update
RUN apt install nano apache2 nginx iputils-ping net-tools -y
ADD conf/apache.conf /etc/apache2/sites-available/www.ads.br.conf
RUN mkdir /var/www/html/ads
RUN mkdir /certs
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /certs/www.ads.key \
-out /certs/www.ads.pem -subj "/C=BR/ST=PB/L=CZ/O=IFPB/CN=www.ads.br"
ADD index.html /var/www/html/ads/index.html
RUN a2enmod ssl
RUN a2ensite www.ads.br.conf
RUN service apache2 stop
ADD conf/nginx.conf /etc/nginx/conf.d/www.ads.br.conf
CMD /bin/bash