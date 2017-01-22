---
layout: post
title:  "Виправлення засинання у Xiaomi Mi Notebook Air"
ref:    suspend-tpm
lang:   uk
date:   2016-12-28 22:38:52 +02:00
tags:   linux systemd
---

Спільна проблема моїх ноутбуків: засинання перестає працювати з другого
разу. Тобто, після першого закриття кришки, комп’ютер засинає,
відкриття його пробуджує, але наступний раз вже невдалий. Або не засинає,
або не прокидається. Лікуванням для [C720](https://www.acer.com/ac/en/US/content/series/c720)
було вивантажити [TPM](https://en.wikipedia.org/wiki/Trusted_Platform_Module)
вручну.

Раніше я робив це скриптом у `/usr/lib/systemd/system-sleep/`.
Але підручник каже, що це грубе рішення, варто було б скористатися кращим інтерфейсом.
[Вікі Arch](https://wiki.archlinux.org/index.php/Power_management#Sleep_hooks)
пропонує створити системний модуль, який буде запущено перед засинанням. Це я й зробив
у моєму Xiaomi Mi Notebook Air:

```shell
$ cat >/etc/systemd/system/root-suspend.service <<END
[Unit]
Description=Local system suspend actions
Before=sleep.target

[Service]
Type=simple
ExecStart=-/usr/bin/rmmod tpm_tis tpm_crb tpm_tis_core tpm

[Install]
WantedBy=sleep.target
END

$ systemctl daemon-reload
```

Здається, допомогло.
