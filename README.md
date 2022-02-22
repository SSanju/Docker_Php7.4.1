# Docker_Php7.4.1
Docker: Custom docker image for PHP 7.4.1

Contains php:7.4.1-apache as base image
With USER root

Contains Lib 
GD
pdo pdo_pgsq
Semaphore php-sysvsem

PORT 9000:80

Docker Imgage 
https://hub.docker.com/r/sanjusurendran/sanju-php-7.4

**
How to use this image**

Create a Dockerfile in your PHP project

FROM sanjusurendran/sanju-php-7.4:latest

COPY . /usr/src/myapp

WORKDIR /usr/src/myapp

CMD [ "php", "./your-script.php" ]

Then, run the commands to build and run the Docker image:


$ docker build -t my-php-app .

$ docker run -it --rm --name my-running-app my-php-app


