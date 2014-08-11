#!/bin/bash

rm -f /var/log/supervisor/*.log

/usr/bin/supervisord -n