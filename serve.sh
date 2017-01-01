#!/bin/bash

set -e

this_dir=`dirname ${BASH_SOURCE[0]}`

mkdir -p _site
mkdir -p /tmp/sakhnik.com
bindfs -n /tmp/sakhnik.com $this_dir/_site

cleanup()
{
	fusermount -u _site
}

trap cleanup EXIT

jekyll serve --incremental
