"""
WSGI entrypoint for Vercel deployment.
This file is required for Vercel to find and run the Django application.
"""

from config.wsgi import application

__all__ = ["application"]
