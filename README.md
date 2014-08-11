docker-lamp-unicontainer
========================

Basic, easy and quick method for build and run a new container for a web app.

This container use Apache, PHP5 and MySQL orchestrate by supervisor.

### Install

Create a dir for your application :

    mkdir /home/user/public/my_app
    cd /home/user/public/my_app

Copy docker-lamp-unicontainer for this app :

    git clone git@github.com:fferriere/docker-lamp-unicontainer.git docker

A new folder has been create named _docker_.
It contains all files for build and run the container.

We recommend to change the container's image name in file _./docker/container-name.conf_

    sed -i -e"s#^CONTAINER_NAME=\"fferriere/full-lamp\"#CONTAINER_NAME=\"namespace/my_app\"#" ./docker/container-name.conf

This file contains the container's image name for this app. If you have some app and you don't change the name you must have conflict.

You must change _DBNAME_, *USER_NAME* and *USER_PASS* in file _./docker/start-mysql.conf_ for each app.

Build the app :

    ./docker/build.sh

Get your app code source :

    git clone git@github.com:Sylius/Sylius.git src

The script for run the container need a src folder.

### Run

Run the container :

    ./docker/run.sh

By default, only web port has bind but you can add bind with mysql port with _-m_ option

    ./docker/run.sh -m

or remove web port bind with _-w_ option

    ./docker/run.sh -w

This script create a ./var_lib_mysql and ./log folders for mount on /var/lib/mysql and /var/log/supervisor.

### Logs

All apps in container has log on /var/log/supervisor, so you can check there on ./log folder.
