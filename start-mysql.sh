#!/usr/bin/env bash

if [ ! -f /var/lib/mysql/ibdata1 ]; then

    mysql_install_db > /dev/null

    ROOT_NAME=root
    ROOT_PASS=root
    DBNAME=database
    USER_NAME=user
    USER_PASS=user

    /usr/bin/mysqld_safe &
    until $(mysqladmin ping > /dev/null 2>&1)
    do
        :
    done
    mysqladmin -u $ROOT_NAME password $ROOT_PASS
    mysqladmin -u $ROOT_NAME -p$ROOT_PASS create $DBNAME
    mysql -u $ROOT_NAME -p$ROOT_PASS <<EOF
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$ROOT_PASS' WITH GRANT OPTION;
    GRANT ALL PRIVILEGES ON user.* TO '$USER_NAME'@'%' IDENTIFIED BY '$USER_PASS';
EOF

    mysqladmin -p$ROOT_PASS shutdown
fi

/usr/bin/mysqld_safe
