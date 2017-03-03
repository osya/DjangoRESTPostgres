web: newrelic-admin run-program gunicorn --pythonpath="$PWD/django_rest_postgres" wsgi:application
worker: python django_rest_postgres/manage.py rqworker default