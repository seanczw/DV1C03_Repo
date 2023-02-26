From ubuntu:18.04
RUN apt update
RUN apt-get install -y apache2
RUN apt clean
EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]
