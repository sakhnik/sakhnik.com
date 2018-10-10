---
layout: post
title:  "Як полагодити роздавання інтернету в Андроїді у мережі Київстар"
ref:    2018-10-10-android-ap
lang:   uk
date:   2018-10-10 23:25:11 +03:00
tags:   android
---

З’ясувалося, що мобільна точка доступу перестала працювати якраз після того, як
[Київстар](http://kyivstar.ua) впровадив 4G. Андроїд пропонує точку доступу до WiFi,
ноутбук до неї під’єднується, але не може досягнути жодного зовнішнього вузла.
Виявилося, що в
[інструкції](https://kyivstar.ua/uk/support/settings/mobile_internet) є прикра
помилка. Коли створюється нова назва точки доступу до мобільної мережі, треба
вказати тип `default,dun`. Джерело: 
[Quora](https://www.quora.com/I-am-not-able-to-share-internet-through-my-mobile-Moto-G-neither-through-WiFi-nor-through-USB-tethering-What-should-I-do).
