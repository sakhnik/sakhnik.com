---
layout: post
title:  "Using systemd-nspawn in Arch Linux ARM for Kerberos.io"
ref:    2018-06-26-alarm-nspawn
lang:   en
date:   2018-06-26 07:28:04 +03:00
tags:   linux
---

Since I started using [kerberos.io](https://kerberos.io), I had to decide how
to install it on my [Raspberry Pi
3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/) running [Arch
Linux ARM](https://archlinuxarm.org/). First I
tried to repackage the official .deb for pacman:
[PKGCONFIG](https://github.com/sakhnik/kerberosio-alarm/commit/3ad2a2a6babc01d277b33bc58a8e806aeff82a73).
It worked out for a while until another Arch update. Then I tried to [build]({%
post_url 2017/2017-12-17-qemu-rpi %}) the machinery by myself. It turned out not
to be easy, ending up with lot of functionality disabled or not reliable.
Finally, I've come to yet another solution: running the genuine
[raspbian](https://www.raspbian.org/) contained [systemd-nspawn]({% post_url
2016/2016-11-28-systemd-nspawn %}) to enable official builds following [the
guide](https://doc.kerberos.io/2.0/installation/Multi-camera/Raspbian).

* So I installed Raspbian into `/var/lib/machines` using debootstrap first (I wish
I could find [aconfmgr]({% post_url 2018/2018-01-18-arch-config %}) for Debian!).

* To launch it manually from the command line:
  ```shell
cd /var/lib/machines && systemd-nspawn --bind /dev/video0 -bD raspbian`
```

* It took some effort to tune the system, install kerberos.io,
  `libraspberrypi-bin` and other dependencies.

* Unfortunately, `machinectl login` doesn't work due to "Protocol error". So had
  to install and configure `ssh` to be listening on `localhost:2222`.

* Then I created configuration and service files to start raspbian automatically
  on boot: [the change](https://github.com/sakhnik/alarmpi3-config/commit/d9fa3fd0e2cff76af525972215bc45ce62b1b234).

* NOTE: the guest uses host networking for simplicity and interoperability with
  [tinc]({% post_url 2018/2018-04-08-tinc %}).

* NOTE: it's required to explicitly specify which mapped dev files to
  allow the access.

* Finally, I could
  [remove](https://github.com/sakhnik/alarmpi3-config/commit/41a3501e7dfe989ac18061cd99a9c777052183c7)
  kerberos.io from the host system.

As an illustration, here is the status of the container:
```
[sakhnik@alarmpi3 ~]$ machinectl status raspbian
raspbian(d2c01930a9414d59a6e15d4f40770785)
           Since: Mon 2018-06-25 09:35:34 EEST; 22h ago
          Leader: 27119 (systemd)
         Service: systemd-nspawn; class container
            Root: /var/lib/machines/raspbian
              OS: Raspbian GNU/Linux 9 (stretch)
            Unit: systemd-nspawn@raspbian.service
                  ├─  956 /usr/bin/kerberosio
                  ├─27117 /usr/bin/systemd-nspawn --quiet --keep-unit --boot --link-journal=try-guest --network-veth -U --sett>
                  ├─27119 /lib/systemd/systemd
                  ├─27133 /lib/systemd/systemd-journald
                  ├─27174 php-fpm: master process (/etc/php/7.0/fpm/php-fpm.conf)
                  ├─27175 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation
                  ├─27178 /usr/sbin/cron -f
                  ├─27180 /lib/systemd/systemd-logind
                  ├─27182 /usr/sbin/rsyslogd -n
                  ├─27183 /usr/sbin/sshd -D
                  ├─27190 /sbin/agetty --noclear --keep-baud console 115200,38400,9600 vt220
                  ├─27192 php-fpm: pool www
                  ├─27193 php-fpm: pool www
                  ├─27194 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
                  ├─27195 nginx: worker process
                  ├─27196 nginx: worker process
                  ├─27197 nginx: worker process
                  ├─27198 nginx: worker process
                  └─27561 php-fpm: pool www
```
