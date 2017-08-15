#!/bin/bash

cd /opt/notejam/django/notejam
python manage.py syncdb --noinput
echo "Syncdb..."
python manage.py migrate
echo "Migrate... "
nohup python manage.py runserver 0.0.0.0:80 >/dev/null 2>&1 &
echo "Server started..."
