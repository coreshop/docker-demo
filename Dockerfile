FROM dpfaffenbauer/pimcore:PHP7.2-apache

ENV SYMFONY_ENV prod
ENV APACHE_DOCUMENT_ROOT /var/www/coreshop/web

RUN composer create-project --no-dev pimcore/skeleton /var/www/coreshop/ \
      && composer require coreshop/core-shop dev-master -d /var/www/coreshop/ 
      
RUN chmod -R 755 /var/www/coreshop/web
RUN chown -R www-data: /var/www/coreshop
RUN chmod +x /var/www/coreshop/bin/console

COPY run.sh /run.sh
COPY wait-for-it.sh /wait-for-it.sh
COPY template/parameters.yml /var/www/pimcore/app/config/parameters.yml
COPY template/DefaultController.php /var/www/coreshop/src/AppBundle/Controller/DefaultController.php 
COPY template/debug-mode.php /var/www/coreshop/var/config/debug-mode.php

RUN chmod +x /wait-for-it.sh

WORKDIR /var/www/coreshop

ENTRYPOINT ["/run.sh"]
CMD ["apache2-foreground"]