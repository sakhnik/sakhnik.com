---
layout: post
title:  "KVM for desktop virtualization retried"
ref:    2017-11-23-kvm-retried
lang:   en
date:   2017-11-23 07:44:50 +02:00
tags:   virt
---

A year ago I concluded that [VirtualBox]({% post_url
/2017/2017-01-22-desktop-virtualization %}) would be the best choice for desktop
virtualization. I ran Windows 7 back then and wasn't able to get [MSYS2]({%
post_url /2016/2016-11-18-win7-msys2 %}) terminal emulator displayed lively. And
now I was to install Windows 10, so took a chance to reevaluate
[KVM](https://www.linux-kvm.org) in pursuit for better performance. This time I
started with [libvirt](https://libvirt.org/) and
[virt-manager](https://virt-manager.org/).

To my surprise, the installation went smoothly, and the performance was
fantastic with all the [virtio](https://wiki.libvirt.org/page/Virtio) drivers.
Even the terminal emulator msys2 drew TUI applications like [midnight
commander](https://midnight-commander.org/) just fine. So it felt in all aspects
like I was going to continue working with KVM until discovered that our [SMPTE
2022-6](https://en.wikipedia.org/wiki/SMPTE_2022) tests don't quite work. They
require transmission/reception of 200k datagrams per second (over localhost),
but the system can't keep up.

Amazingly, whenever I converted the images to VirtualBox (takes 5 minutes
actually), the tests started to pass without any further change. So I will
continue using it for another year.

Conclusions:

* KVM became better and I could go with it in terms of GUI
* VirtualBox is still the better choice for desktop virtualization
* I improved performance by allocating space for disk C: on the SSD (64G
  should be enough)
* Don't trust what they say, try for your application by yourself.
