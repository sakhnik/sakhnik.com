---
layout: post
title:  "Використання systemd-nspawn у Arch Linux ARM для Kerberos.io"
ref:    2018-06-26-alarm-nspawn
lang:   uk
date:   2018-06-26 07:28:04 +03:00
tags:   linux
---

З тих пір, як я почав використовувати [kerberos.io](https://kerberos.io), треба
було вирішувати, як його встановити на [Raspberry Pi
3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/), який працює
під керуванням [Arch Linux ARM](https://archlinuxarm.org/).
Спершу намагався перепаковувати офіційні пакунки .deb для pacman:
[PKGCONFIG](https://github.com/sakhnik/kerberosio-alarm/commit/3ad2a2a6babc01d277b33bc58a8e806aeff82a73).
Це деякий час спрацьовувало до якогось чергового поновлення. Потім спробував [збирати]({%
post_url 2017/2017-12-17-qemu-rpi.uk %}) самотужки. Виявилося, що це непросто,
багато функціональності або працює ненадійно, або довелося взагалі вимкнути.
Нарешті, з’явилося ще один розв’язок: запустити справжній
[raspbian](https://www.raspbian.org/) з допомогою [systemd-nspawn]({% post_url
2016/2016-11-28-systemd-nspawn.uk %}), щоб можна було встановлювати офіційні
збірки з допомогою [посібника](https://doc.kerberos.io/2.0/installation/Multi-camera/Raspbian).

* Тож спершу я встановив Raspbian у `/var/lib/machines` з допомогою (якби ж то
був [aconfmgr]({% post_url 2018/2018-01-18-arch-config.uk %}) для Debian!).

* Щоб його запустити з командного рядка:
  ```shell
cd /var/lib/machines && systemd-nspawn --bind /dev/video0 --bind /dev/vchiq -bD raspbian`
```

* Трішки довелося постаратися, щоб налаштувати систему, встановити kerberos.io,
  `libraspberrypi-bin` і інші залежності (оновлено: створив скрипт для встановлення
  raspbian у chroot автоматизовано:
  [prepare-raspbian-kerberosio.sh](https://github.com/sakhnik/scripts/blob/bdfefe2d2f21a83c9224af60628a7e277eff5095/prepare-raspbian-kerberosio.sh)).

* Потім створив конфігураційні і сервісні файли, щоб raspbian запускався
  автоматично разом із основною системою:
  [зміна](https://github.com/sakhnik/alarmpi3-config/commit/d9fa3fd0e2cff76af525972215bc45ce62b1b234).

* Примітка: гостьова система використовує мережу батьківської системи для
  простоти і взаємодії з [tinc]({% post_url 2018/2018-04-08-tinc.uk %}).

* Примітка: необхідно чітко зазначити, до яких із відображених файлів пристроїв
  надати доступ.

* Нарешті, вже можна було
  [прибрати](https://github.com/sakhnik/alarmpi3-config/commit/41a3501e7dfe989ac18061cd99a9c777052183c7)
  kerberos.io з основної системи.

Як ілюстрація, ось стан контейнера:
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
