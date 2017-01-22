---
layout: post
title:  "Notes on desktop virtualization"
ref:    2017-01-22-virtualization
lang:   en
date:   2017-01-22 08:34:40 +02:00
tags:   virt
---

Hardware assisted virtualization shouldn't necessarily be better than dynamic
translation just because _"hardware"_ in it. My experiments concluded that the
best solution for desktop virtualization has been VirtualBox so far.

Let's step aside first. When I tried
[VMWare Player](http://www.vmware.com/products/player/playerpro-evaluation.html), 
it wouldn't integrate into Arch linux well. It required a more stable kernel to
build its modules, a custom installer, custom scripts to update, uninstall. Not
to mention that it's closed source and not free for commercial use.

Then when I tried [KVM](http://www.linux-kvm.org), I was able to set up
Windows 7. It was quite usable with [SPICE](https://www.spice-space.org/). But
then when I needed [msys2](_posts/2016/2016-11-18-win7-msys2.md), it turned out
that graphics performance became unbearable.

So I got/returned to [VirtualBox](https://www.virtualbox.org/wiki/VirtualBox).
It's easy to install and maintain in my Arch linux, it offers exellent
performance of guest Windows, good integration of desktops. Now, unlike KVM,
it'd be possible to run on a station without CPU supporting virtualization. Hard
to imagine today though.

One more note to put down: Oracle [binary](https://aur.archlinux.org/packages/virtualbox-bin/)
package seems to be more stable than OSE one. For instance, mouse pointer
transparency is handled better.
