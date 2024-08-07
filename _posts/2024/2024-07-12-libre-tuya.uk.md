---
layout: post
title:  Звільнення WiFi розетки Tuya
ref:    2024-07-12-liberate-tuya
lang:   uk
date:   2024-07-12 17:32:53 +03:00
tags:   linux iot esphome libretuya home-assistant
---

Нині я користуюся Home Assistant для керування електричним обладнанням удома.
Це дивовижний крок вперед з часу моїх перших кроків в автоматизації
[минулого року]({%
post_url /2023/2023-01-01-enter-iot.uk %}). Я застосовую
[ESPHome](https://esphome.io) як альтернативну мікропрограму для розумних
розеток Sonoff S26, що базуються на поширеному мікроконтролері ESP8266. Але
зараз простіше знайти дешевші розетки Tuya 20A за 150₴ (нижче 4$) за штуку.
До того ж вони мають вимірювач спожитої енергії. Але виклик в тому, що вони
використовують чип LibreTiny BK7231N. Ось що я навчився робити.

Спершу я спробував
[tuya-couldcutter](https://github.com/tuya-cloudcutter/tuya-cloudcutter).
Потенційно він міг допомогти з моєю розеткою Aubess 20A, але він не впорався
саме із моєю версією. Напевне, Tuya виправила вразливість. Тож довелося
відкривати корпус щоб приєднати послідовний програматор.

Щоб це здійснити без руйнування — це справжній виклик. На відміну від Sonoff, ці
розетки не скріплені ніякими болтами чи шурупами. Частини корпусу склеєні і
подолати клей можна поступово прикладаючи тиск, щоб легенько деформувати корпус.
Дехто використовує лещата і
[струбцини](https://www.youtube.com/watch?v=AK7Aibrhzbs). Мені ж вдалося в
якості важеля застосувати вхідні двері.

![Двері-лещата](/assets/2024-07/door-clamp.jpg)

![BK7231N](/assets/2024-07/bk7231n.jpg)

Виходи плати [C2BS](https://docs.libretiny.eu/boards/cb2s)
([специфікація](https://developer.tuya.com/en/docs/Document/cb2s-module-datasheet))
розпізнати легко. Я застосовую [прищепки до
мікросхем](https://www.aliexpress.com/item/1005005936436715.html) з Алі Експрес,
щоб приєднати програматор.

![Прищепки до мікросхеми](/assets/2024-07/ic-clamps.jpg)

Конфігурування ESPHome можна почати з онлайн-інструменту
[UPK2ESPHome](https://upk.libretiny.eu/). Нарешті, щоб встановити мікропрограму,
досить виконати `esphome run tuya-1.yml`. Що зручно, ця програма підказує, як
під’єднати програматор і як скинути мікроконтролер, поки записувач чекає на
з’єднання (заземлити вихід CEN). Можливо, знадобиться кілька спроб через
ненадійне підключення, але зрештою запис вдається.

Тепер крім очевидного застосування розумного вимикача у Home Assistant, є кілька
неочікуваних можливостей. По-перше, це платформа для вбудованого ПЗ в
елегантному корпусі, під’єднана до мережі WiFi і зручно заживлена від
стандартної розетки 220В. По-друге, BK7231N спроможний вести обмін даними через
BLE. Тож потенційно можна було б портувати [esphome-jk-bms](https://github.com/syssi/esphome-jk-bms)
з ESP32, щоб створити дешевий і зручний нагляд за батареєю.

![Дошка HA](/assets/2024-07/ha-dashboard.png)
