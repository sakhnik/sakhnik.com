---
layout: post
title:  "Portable media library with Shotwell"
ref:    portable-shotwell
lang:   en
date:   2016-11-14 22:08:36 -05:00
tags:   media unix
---

[Shotwell](https://wiki.gnome.org/Apps/Shotwell) is a great photo manager for
GNOME. It imports photos to conventional `~/Pictures`, stores meta information
as well as thumbnails somewhere deep in hidden directories. Now consider my
requirements:

* Need to keep media files on a portable USB HDD, because my computer may have
limited SSD
* Need to keep meta information and thumbnails close to the photos to simplify
backup
* Should be able to stick into another GNOME station and have the photo
collection ready to use.

The solution is blazingly simple: mount bind directories from the portable
media to usual locations before launching Shotwell, and carefully unmount
afterwards.

```shell
#!/bin/bash

# Launch shotwell on portable photo collection

# Usage:
#   ./launch-shotwell.sh

set -e

# Assuming this script is located inside portable Pictures
pics_dir=$(readlink -f `dirname ${BASH_SOURCE[0]}`)

echo "Source directory is $pics_dir"

cleanup()
{
    echo "$cleanup_actions"
    eval "$cleanup_actions"
}

trap cleanup EXIT

mount_directory()
{
    msg="$1"; src=$2; dst=$3
    echo "Mounting $msg from $src"
    mkdir -p $dst
    # Cone could use fuse bindfs to avoid entering password
    sudo mount -o bind $src $dst
    cleanup_actions="sudo umount $dst; $cleanup_actions"
}

mount_directory "pictures" $pics_dir ~/Pictures
mount_directory "shotwell database" $pics_dir/shotwell ~/.local/share/shotwell
mount_directory "thumbnail cache" $pics_dir/shotwell/.cache ~/.cache/shotwell

shotwell
```

Now it's awesome to realize that media library is persistent across multiple
PCs!
