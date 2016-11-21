---
layout: post
title:  "Automation of a VPN client"
date:   2016-11-21 22:47:41 +02:00
tags:   unix cli expect systemd
---

I had to connect to VPN today. It happened to require open source
client [shrew soft](https://www.shrew.net/home). Arch linux offers AUR package
[ike](https://aur.archlinux.org/packages/ike) for that. It's easy to use, but
annoyingly interactive, and ultimately takes one dangling terminal.
Consider typical session:

```
kionia:~ % ikec -r Company
ii : ## : VPN Connect, ver 2.2.1
## : Copyright 2013 Shrew Soft Inc.
## : press the <h> key for help
>> : config loaded for site 'Company'
ii : Use the following keys to control client connectivity
 - : <c> connect
 - : <d> disconnect
 - : <h> help
 - : <s> status
 - : <q> quit
>> : attached to key daemon ...
>> : peer configured
>> : iskamp proposal configured
>> : esp proposal configured
>> : client configured
<< : enter xauth username : asakhnik
<< : enter xauth password :

>> : local id configured
>> : remote id configured
>> : pre-shared key configured
ii : bringing up tunnel ...
>> : network device configured
ii : tunnel enabled

```

Now I'm going to show how to use [expect](http://expect.sourceforge.net/) to
let systemd do this routine automatically on my login.

First we create a script to interact with the VPN client (`~/bin/company.exp`):
```expect
#!/usr/bin/expect

spawn ikec -r Company

expect "config loaded"
send c

expect "xauth username : " { send "asakhnik\r" }
expect "xauth password : " { send "MyVerySecretPassword\r" }

expect "tunnel enabled"

wait
```

Then we create a custom user service for systemd
(`~/.config/systemd/user/company-vpn.service`):
```init
[Unit]
Description=Company VPN access

[Service]
ExecStart=/home/sakhnik/bin/company.exp

[Install]
WantedBy=default.target
```

And finally, enable it in systemd:
```shell
systemctl --user daemon-reload
systemctl --user start company-vpn.service
systemct --user enable company-vpn.service
```

That's it, one minute less for everyday typing, plus one point to karma ;-)
