---
layout: post
title:  "Fixing suspend in Xiaomi Mi Notebook Air"
ref:    suspend-tpm
lang:   en
date:   2016-12-28 22:38:52 +02:00
tags:   linux systemd
---

The common issue in my notebooks: suspend (sleep to RAM) stops working every
second time. I.e., the first time I close the lid, the laptop falls asleep,
open lid awakens, but the second time is unsuccessful. Either no suspend,
or no wakeup. The cure in [C720](https://www.acer.com/ac/en/US/content/series/c720)
was to unload [TPM](https://en.wikipedia.org/wiki/Trusted_Platform_Module)
manually.

Earlier I did this dropping a script into `/usr/lib/systemd/system-sleep/`.
But manual page says this was a hack, there could be a nicer interface used
for that. [Arch wiki](https://wiki.archlinux.org/index.php/Power_management#Sleep_hooks)
suggested creating a systemd unit to be executed prior suspend. So did I
in my Xiaomi Mi Notebook Air:

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

Seems to have helped.
