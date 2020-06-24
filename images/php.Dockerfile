FROM php:7.2-fpm
#FROM mygento/php:7.2-full
MAINTAINER Tao309 <tao309@mail.ru>

RUN apt-get update -y && apt-get install -y \
        curl \
        git \
        zip \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        libzip-dev

RUN docker-php-ext-install bcmath mbstring xsl intl soap zip

RUN apt-get install -y libmcrypt-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt

RUN apt-get update && apt-get install -y \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev

RUN docker-php-ext-configure gd \
    --with-gd \
    --with-webp-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib-dir \
    --with-xpm-dir \
    --with-freetype-dir

RUN docker-php-ext-install gd

#RUN docker-php-ext-configure gd
#--with-png=/usr/include/
#--with-jpeg=/usr/include/
#--with-freetype=/usr/include/


#RUN apt-get install -y libxslt-dev
#RUN docker-php-ext-install -j$(nproc) intl
#
#RUN docker-php-ext-install xsl
#RUN docker-php-ext-install intl

RUN apt-get install -y openssl
#RUN apt install libmcrypt-dev && docker-php-ext-configure mcrypt && docker-php-ext-install mcrypt

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#RUN apt-get install -y curl \
#  && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
#  && apt-get install -y nodejs \
#  && curl -L https://www.npmjs.com/install.sh | sh

RUN docker-php-ext-install pdo pdo_mysql


## Authorize SSH Host
#RUN mkdir -p /root/.ssh && \
#    chmod 0700 /root/.ssh && \
#    ssh-keyscan github.com > /root/.ssh/known_hosts
#
#ADD config/id_rsa /root/.ssh/id_rsa
#
## Add the keys and set permissions
#RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
#    echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
#    chmod 600 /root/.ssh/id_rsa && \
#    chmod 600 /root/.ssh/id_rsa.pub
#
## Remove SSH keys
#RUN rm -rf /root/.ssh/

#
RUN mkdir -p /root/.ssh
#ADD ./config/id_rsa /root/.ssh/id_rsa
#ADD ./config/id_rsa /root/.ssh/id_rsa
#RUN chmod 0700 /root/.ssh/id_rsa
RUN ssh-keyscan bitbucket.org > /root/.ssh/known_hosts

# chmod 0700 /root/.ssh/id_rsa && eval $(ssh-agent) && ssh-add /root/.ssh/id_rsa
# php -d memory_limit=1G /usr/local/bin/composer update
# chmod 777 -R var/


#RUN chown www-data:www-data /etc$HOME/.ssh/id_rsa;
#RUN chmod 777 /etc/root/.ssh/id_rsa;
#RUN eval $(ssh-agent)
##RUN eval `ssh-agent -s`
#RUN ssh-add /etc/root/.ssh/id_rsa

#RUN chown www-data:www-data -R /var/www;

#root/.composer/auth.json

WORKDIR /var/www

CMD ["php-fpm"]