#/usr/bin/env python

from setuptools import setup, find_packages

setup(
	name='polybar-spotify-status',
	version='1.0',
	packages=find_packages(),
	scripts=["spotify_status.py"],
)
