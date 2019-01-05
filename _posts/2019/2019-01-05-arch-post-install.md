---
layout: post
title:  "Checklist for configuration of fresh Arch Linux"
ref:    2019-01-05-arch-post-install
lang:   en
date:   2019-01-05 08:26:58 +02:00
tags:   linux
---

This is a checklist of what to do on a freshly installed Arch Linux.
It's going to be refined constantly.

- Make sure `discard` is among the options in `/etc/fstab` for SSD
- Configure the `noop` scheduler for non-rotational storage
    - Make it permanent with [tmpfiles](https://github.com/sakhnik/arch-config/blob/e8465b735a75212114595cd2fda979d30702644b/30-hardware.sh#L20)
- Configure makepkg flags
    - See example from [kionia](https://github.com/sakhnik/arch-config/blob/e8465b735a75212114595cd2fda979d30702644b/20-pacman.sh#L77)
- Install [yay](https://github.com/Jguer/yay)
    - Either from the source code (requires Go compiler)
    ([yay<sup>AUR</sup>](https://aur.archlinux.org/packages/yay/))
    - Or prebuilt
    ([yay-bin<sup>AUR</sup>](https://aur.archlinux.org/packages/yay-bin/))
    - Consider setting a custom build directory: `yay --save --builddir=/tmp -Syu`
- Install GNOME with the dependencies (like xorg)
    - Install `xf86-video-intel` or another appropriate
    - Test gdm starting, enable it permanently `sudo systemctl enable
        gdm.service`
- Install chromium with bunch of suggested TTF fonts
- Install gnome-tweaks
    - Configure desired behaviour of the touchpad
    - Configure theme (dark, light)
    - Configure font rendering (subpixel)
- Install [powertop](https://wiki.archlinux.org/index.php/Powertop)
    - Tune the power consumption
- Install `networkmanager`, `nm-connection-editor`
- Install [systemd-swap](https://github.com/Nefelim4ag/systemd-swap)
    - Configure the [swap](https://wiki.archlinux.org/index.php/Swap#systemd-swap)
- Install `openssh`
- Install `pacman-contrib`
    - Add pacman hooks to clear the cache after upgrades:
   [paccache-*](https://github.com/sakhnik/arch-config/blob/e8465b735a75212114595cd2fda979d30702644b/20-pacman.sh)
- Limit journald size
    - See [00-journal-size.conf](https://github.com/sakhnik/arch-config/blob/e8465b735a75212114595cd2fda979d30702644b/40-systemd.sh#L8)
- Install and enable [earlyoom](https://github.com/rfjakob/earlyoom) from
    [earlyoom<sup>AUR</sup>](https://aur.archlinux.org/packages/earlyoom/)
- Configure [tinc](https://wiki.archlinux.org/index.php/Tinc), add to one of my networks
- Configure [Hardware video acceleration](https://wiki.archlinux.org/index.php/Hardware_video_acceleration)
    - Install `libva`, `libva-utils`, `libva-intel-driver`
    - Add the user to the group `video`
    - Test `vainfo`
- Install `pavucontrol`
