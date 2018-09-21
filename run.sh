#!/bin/bash
cd /var/www/coreshop

/wait-for-it.sh db:3306

MHOST="db"
MUSER="pimcore"
MPASS="pimcore"
MDB="pimcore"

su -u www-data /var/www/coreshop/vendor/bin/pimcore-install --admin-username admin --admin-password coreshop --mysql-host-socket $MHOST --mysql-username $MUSER --mysql-password $MPASS --mysql-database $MDB --no-interaction --ignore-existing-config --no-debug

su -u www-data /var/www/coreshop/bin/console cache:clear --no-warmup --no-interaction
su -u www-data /var/www/coreshop/bin/console pimcore:bundle:enable CoreShopCoreBundle --no-interaction
su -u www-data /var/www/coreshop/bin/console assets:install --no-interaction
su -u www-data /var/www/coreshop/bin/console coreshop:install --no-interaction

su -u www-data /var/www/coreshop/bin/console coreshop:install:demo --no-interaction

exec $@