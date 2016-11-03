#!/bin/bash

export JEKYLL_ENV=production

jekyll build --incremental
rsync -raP --chown 33:33 _site/* iryska.do:/var/www/sakhnik.com.ua
