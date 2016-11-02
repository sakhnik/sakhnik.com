#!/bin/bash

jekyll build --incremental
rsync -raP --chown 33:33 _site/* iryska.do:/var/www/sakhnik.com.ua
