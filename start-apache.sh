#!/bin/bash

HTTPDUSER="www-data"

setfacl -R -m u:"$HTTPDUSER":rwX -m u:"user":rwX /var/www/
setfacl -dR -m u:"$HTTPDUSER":rwX -m u:"user":rwX /var/www/

source /etc/apache2/envvars
exec apache2 -D FOREGROUND
