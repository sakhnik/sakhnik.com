---
layout: post
title:  "HTTPS with Let's Encrypt"
ref:    2017-01-25-letsencrypt
lang:   en
date:   2017-01-25 21:19:39 +02:00
tags:   web
---

I got to it finally: set up HTTPS on my sites using free, automated, and open
Certified Authority [Let's Encrypt](https://letsencrypt.org).

It turned out to be a matter of executing a step-by-step
[instruction](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-16-04).
The keys are to be renewed automatically in a `cron` job, while I'll just be
watching over the sites:

* [`sakhnik.com`](https://sakhnik.com)
* [`ttrss.sakhik.com`](https://ttrss.sakhnik.com)
* [`uarty.com.ua`](https://uarty.com.ua)
* [`kidfun.com.ua`](https://kidfun.com.ua)

I'm also thinking about migrating [`iryska.com.ua`](https://iryska.com.ua),
which is currently using a traditional certificate.

![Let's Encrypt](/assets/2017-01/letsencrypt.png)
