FROM php:7.2-fpm
MAINTAINER Tao309 <tao309@mail.ru>

RUN apt-get update && apt-get -yq upgrade

RUN apt-get install -y \
        curl \
        git \
        zip \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        libzip-dev \
        ssh \
        openssl

RUN docker-php-ext-install bcmath mbstring xsl intl soap zip

# Start ssh
#RUN mkdir -p /root/.ssh \
#    && chmod 0700 /root/.ssh \
#    && ssh-keyscan bitbucket.org > /root/.ssh/known_hosts

RUN mkdir -m 700 /root/.ssh \
  && ssh-keyscan bitbucket.org > /root/.ssh/known_hosts

RUN echo "${SSH_PRIVATE_KEY}" >> /root/.ssh/magento_rsa \
    && echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub \
    && chmod 600 /root/.ssh/magento_rsa.pub \
    && chmod 600 /root/.ssh/magento_rsa

#RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/mygento_rsa && chmod 600 /root/.ssh/id_rsa
RUN eval $(ssh-agent -s) && ssh-add /root/.ssh/id_rsa && ssh-add -l
#RUN ls -l /root/.ssh/

#ADD ./../config/id_rsa /root/.ssh/id_rsa
#COPY ../config/ssh/ /root/.ssh/
#RUN chmod 600 /root/.ssh/id_rsa

#RUN chown -R root:root /root/.ssh; chmod 700 /root/.ssh; chmod 600 /root/.ssh/config

#RUN eval $(ssh-agent -s) && ssh-add /root/.ssh/id_rsa && ssh-add -l

# End ssh


WORKDIR /var/www

#ENTRYPOINT eval $(ssh-agent -s) && ssh-add /root/.ssh/magento_rsa

CMD ["php-fpm"]