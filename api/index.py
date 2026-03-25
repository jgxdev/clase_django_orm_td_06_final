import os
import sys

# Añade el root del proyecto
sys.path.append(os.path.dirname(os.path.dirname(__file__)))

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')

from django.core.asgi import get_asgi_application

app = get_asgi_application()