#!/bin/bash

set -e

root_dir=`dirname ${BASH_SOURCE[0]}`/..

mkdir -p _site
mkdir -p /tmp/sakhnik.com
bindfs -n /tmp/sakhnik.com $root_dir/_site

cleanup()
{
	fusermount -u _site
}

trap cleanup EXIT

jekyll serve --incremental
