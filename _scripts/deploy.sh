#!/bin/bash -e

export JEKYLL_ENV=production

bundle exec jekyll build

ssh iryska.do 'rm -rf /var/www/sakhnik.com/*'
rsync -raP --chown 33:33 _site/* iryska.do:/var/www/sakhnik.com