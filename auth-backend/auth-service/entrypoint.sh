#!/bin/sh

set -e

echo "Waiting for database..."

until python -c "
import MySQLdb
import os

MySQLdb.connect(
    host=os.environ['DB_HOST'],
    port=int(os.environ.get('DB_PORT', 3306)),
    user=os.environ['DB_USER'],
    passwd=os.environ['DB_PASSWORD'],
    database=os.environ['DB_NAME']
)
"; do
    echo "Database not ready. Waiting..."
    sleep 2
done

echo "Database is ready!"

echo "Running database migrations....."
python manage.py migrate --noinput

echo "Creating superuser if it does not exist....."

python manage.py shell <<EOF
from django.contrib.auth import get_user_model

User = get_user_model()

username = "shopflow-auth"
email = ""
password = "shopflow_auth@12345"

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
exec python manage.py runserver 0.0.0.0:8000