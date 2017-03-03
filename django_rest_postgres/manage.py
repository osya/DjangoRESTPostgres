#!/usr/bin/env python
import os
import sys

if sys.argv[0] and 'django_test_manage.py' in sys.argv[0]:
    os.environ.setdefault("DJANGO_CONFIGURATION", "Local")
    import configurations
    configurations.setup()

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config")
    os.environ.setdefault("DJANGO_CONFIGURATION", "Local")

    if sys.argv[0] and sys.argv[0].find('django_test_manage.py'):
        import configurations

        configurations.setup()

    try:
        from configurations.management import execute_from_command_line
    except ImportError:
        # The above import may fail for some other reason. Ensure that the
        # issue is really that Django is missing to avoid masking other
        # exceptions on Python 2.
        try:
            import django  # noqa
        except ImportError:
            raise ImportError(
                "Couldn't import Django. Are you sure it's installed and "
                "available on your PYTHONPATH environment variable? Did you "
                "forget to activate a virtual environment?"
            )
        raise
    execute_from_command_line(sys.argv)
