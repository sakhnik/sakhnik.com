---
layout: post
title:  "Резервування світлин з андроїда"
ref:    2017-04-29-photo-sync
lang:   uk
date:   2017-04-29 21:05:20 +03:00
tags:   android linux
---

Кілька разів я шкодував про втрачені світлини:
* Коли зіпсувалася картка пам’яті
* Коли діти гралися (особливо з дозволу)

Нарешті, спало на думку налаштувати якусь автоматичну синхронізацію з телефону
на [мережеве сховище](https://uk.wikipedia.org/wiki/Network-attached_storage).
В ідеалі, вона повинна працювати тільки у домашній мережі, під час заряджання.
На щастя, знайшовся готовий додаток для Андроїду: [Sweet Home WiFi Picture
Backup](https://play.google.com/store/apps/details?id=sweesoft.sweethome).

Додаток потребує сервер CIFS/SAMBA у мережі, тож я налаштував його на
[малині](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/),
використовуючи [вікі Arch](https://wiki.archlinux.org/index.php/samba).
І ось результат: дешевий сервер з 32 ГБ сховища, телефони вивантажують свої фото
щокілька днів, коли заряджаються, і світлини в безпеці.
