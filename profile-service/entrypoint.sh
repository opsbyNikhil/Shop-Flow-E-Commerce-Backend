#!/bin/sh
set -e

echo "Running databsae migrations....."
python manage.py migrate --noinput

echo "Creating superuser if it does not exist....."

python manage.py shell <<EOF
from django.contrib.auth import get_user_model

User = get_user_model()

username = "shopflow-profile"
email = ""
password = "shopflow_profiles@12345"

if not User.objects.filter(username=username).exists():
    User.objects.create_superuser(
        username=username,
        email=email,
        password=password
    )
    print("Superuser created successfully.")
else:
    print("Superuser already exists.")
EOF


echo "Running static files....."
python manage.py collectstatic --noinput

echo "Running Django Server....."
exec python manage.py runserver 0.0.0.0:8005