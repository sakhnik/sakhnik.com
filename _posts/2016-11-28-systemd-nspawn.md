---
layout: post
title:  "Linux containers with systemd-nspawn"
date:   2016-11-28 22:27:49 +02:00
tags:   linux virt systemd
---

When I needed specific linux distribution on a modern linux host, I used to
utilize
[schroot](https://wiki.archlinux.org/index.php?title=Install_bundled_32-bit_system_in_64-bit_system&redirect=no#Schroot).
More robust solution would be to use
[LXC](https://wiki.archlinux.org/index.php/Linux_Containers). However the same
page suggests
[systemd-nspawn](https://wiki.archlinux.org/index.php/Systemd-nspawn) as an
alternative. So I tried it the other day when needed to prepare CentOS 7 for
my work.

Setup is easy: just obtain root file system tree. Needed to work around
inaccessible `/tmp/.X11-unix` within the container --- bound directory
explicitly from non-tmpfs. Created launch script to launch the system
conveniently:
```bash
#!/bin/bash

cur_dir=`readlink -f $(dirname ${BASH_SOURCE[0]})`

xhost +local:

# Note that --bind /tmp/.X11-unix doesn't actually preserve sockets,
# pass them through /w

sudo systemd-nspawn \
    -D $cur_dir/centos \
    -b \
    -n \
    --bind /w \
    --bind /home/sakhnik
```

The result is impressive. The system "boots" into login terminal:

![Booted CentOS 7]({{ site.url }}/assets/2016-11/systemd-nspawn.png)

I used virtual network ethernet connection in the container with
`systemd-networkd`:

![Network configuration]({{ site.url }}/assets/2016-11/systemd-nspawn2.png)

So far, so good. Let's see later how usable the container is.
