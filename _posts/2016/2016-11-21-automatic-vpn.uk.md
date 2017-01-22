---
layout: post
title:  "Автоматизація клієнта VPN"
ref:    ike-expect
lang:   uk
date:   2016-11-21 22:47:41 +02:00
tags:   unix systemd
---

Треба було з’єднатися сьогодні з VPN. Для цього був потрібен клієнт з відкритим початковим кодом
[shrew soft](https://www.shrew.net/home). В дистрибутиві Arch для цього навіть є пакунок AUR
[ike](https://aur.archlinux.org/packages/ike). Його легко використовувати, але
він набридливо інтерактивний і, зрештою, займає цілий термінал.
Розгляньмо типовий сеанс:

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

Тепер я покажу, як запрягти [expect](http://expect.sourceforge.net/), щоб
цю рутину для мене виконував systemd щоразу при вході в систему.

Спочатку створюємо скрипт для взаємодії з клієнтом VPN (`~/bin/company.exp`):
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

Потім створюємо нову службу користувача для systemd
(`~/.config/systemd/user/company-vpn.service`):
```init
[Unit]
Description=Company VPN access

[Service]
ExecStart=/home/sakhnik/bin/company.exp

[Install]
WantedBy=default.target
```

Нарешті, вмикаємо її:
```shell
systemctl --user daemon-reload
systemctl --user start company-vpn.service
systemct --user enable company-vpn.service
```

Це все, на одну хвилину менше щоденної рутини, одне очко до карми ;-)
