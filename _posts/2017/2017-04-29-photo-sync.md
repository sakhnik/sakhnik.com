---
layout: post
title:  "Backup photos from android phone"
ref:    2017-04-29-photo-sync
lang:   en
date:   2017-04-29 21:05:20 +03:00
tags:   android linux
---

There were few times that I regretted about lost photos:
* Micro SD card failure
* Kids playing around (especially with permission)

Finally, there came the idea to implement a kind of automatic synchronization
from phone to a [network-attached
storage](https://en.wikipedia.org/wiki/Network-attached_storage).  Ideally, it
should do its job in home network only, during charging. Luckily, I found a
ready application for Android: [Sweet Home WiFi Picture
Backup](https://play.google.com/store/apps/details?id=sweesoft.sweethome).

The application requires a CIFS/SAMBA server in the network, so I installed it
on the [Raspberry PI
3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/), using [Arch
Wiki](https://wiki.archlinux.org/index.php/samba).  And there it is, the cheap
server with 32 GB storage, phones uploading their photos every few days when
being charged, and the photos in safety.
