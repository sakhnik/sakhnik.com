---
layout: post
title:  "HTTPS з Let's Encrypt"
ref:    2017-01-25-letsencrypt
lang:   uk
date:   2017-01-25 21:19:39 +02:00
tags:   web
---

Нарешті добрався: встановив HTTPS на моїх серверах, використовуючи безкоштовний,
автоматизований і відкритий акредитований центр сертифікації ключів
[Let's Encrypt](https://letsencrypt.org).

Виявилося, що треба тільки виконати покрокову
[інструкцію](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-16-04).
Ключі будуть оновлюватися автоматично задачею `cron`, а я буду тільки наглядати
над серверами:

* [`sakhnik.com`](https://sakhnik.com)
* [`ttrss.sakhik.com`](https://ttrss.sakhnik.com)
* [`uarty.com.ua`](https://uarty.com.ua)
* [`kidfun.com.ua`](https://kidfun.com.ua)

Також розмірковую, чи не налаштувати також [`iryska.com.ua`](https://iryska.com.ua),
який поки що використовує традиційний сертифікат.

![Let's Encrypt](/assets/2017-01/letsencrypt-uk.png)
