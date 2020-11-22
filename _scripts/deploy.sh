#!/bin/bash -e

export JEKYLL_ENV=production

bundle exec jekyll build

host=iryska

ssh $host 'rm -rf /var/www/sakhnik.com/*'
rsync -raP --chown 33:33 _site/* $host:/var/www/sakhnik.com
