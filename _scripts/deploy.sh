#!/bin/bash

set -e

export JEKYLL_ENV=production

root_dir=`dirname ${BASH_SOURCE[0]}`/..

mkdir -p _site
mkdir -p /tmp/sakhnik.com-production

bindfs -n /tmp/sakhnik.com-production $root_dir/_site

cleanup()
{
	fusermount -u _site
}

trap cleanup EXIT

jekyll build

rsync -raP --chown 33:33 _site/* iryska.do:/var/www/sakhnik.com
