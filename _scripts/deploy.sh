#!/bin/bash -e

export JEKYLL_ENV=production

bundle exec jekyll build

host=iryska

rsync -raP --delete --chown 33:33 _site/* $host:/var/www/sakhnik.com/
