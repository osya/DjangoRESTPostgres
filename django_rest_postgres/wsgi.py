"""
WSGI config for django_rest_postgres project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.8/howto/deployment/wsgi/
"""
import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config")
os.environ.setdefault("DJANGO_CONFIGURATION", "Local")

from configurations.wsgi import get_wsgi_application  # noqa
from whitenoise.django import DjangoWhiteNoise        # noqa

application = get_wsgi_application()
application = DjangoWhiteNoise(application)
