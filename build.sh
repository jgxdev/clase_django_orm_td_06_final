#!/bin/bash
set -e

echo "=== BUILD START ==="
echo "Python version: $(python --version)"
echo "Pip version: $(pip --version)"
echo "Database URL: ${DATABASE_URL:-<no DATABASE_URL>}" 

echo "Installing dependencies..."
pip install -r requirements.txt

echo "Checking Django migrations status..."
python manage.py migrate --plan

echo "Making migrations (if needed)..."
python manage.py makemigrations --noinput || true

echo "Running migrations..."
python manage.py migrate --noinput

echo "Migrated tables:"
python manage.py showmigrations

echo "Collecting static files..."
python manage.py collectstatic --noinput --clear

echo "Creating superuser..."
if [ -n "$DJANGO_SUPERUSER_USERNAME" ] && [ -n "$DJANGO_SUPERUSER_EMAIL" ] && [ -n "$DJANGO_SUPERUSER_PASSWORD" ]; then
    python manage.py createsuperuser --noinput --username="$DJANGO_SUPERUSER_USERNAME" --email="$DJANGO_SUPERUSER_EMAIL" || true
fi

echo "=== BUILD COMPLETED SUCCESSFULLY ==="
