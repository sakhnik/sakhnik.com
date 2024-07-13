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

First of all, I tried
[tuya-couldcutter](https://github.com/tuya-cloudcutter/tuya-cloudcutter). While
it could potentially help with my Aubess 20A switch, it failed with my specific
version. Probably, Tuya patched the vulnerability. So I have to open the case to
attach a serial programmer.

To open the case without destroying it is a challenge. Unlike Sonoff, these
plugs don't have any screws. The case is glued and the glue can be broken by
applying pressure gradually to deform the case slightly. Some people use
[clamps](https://www.youtube.com/watch?v=AK7Aibrhzbs). I succeeded using entry
door as a leverage.

![Door clamp](/assets/2024-07/door-clamp.jpg)

The pins of the board [C2BS](https://docs.libretiny.eu/boards/cb2s)
([datasheet](https://developer.tuya.com/en/docs/Document/cb2s-module-datasheet))
are easy to identify. I use [IC
clamps](https://www.aliexpress.com/item/1005005936436715.html) from AliExpress
to attach the programmer.

![IC clamps](/assets/2024-07/ic-clamps.jpg)

ESPHome configuration could be bootstraped using an online tool
[UPK2ESPHome](https://upk.libretiny.eu/). And finally, to install the firmware,
it's enough to run `esphome run tuya-1.yml`. Conveniently, it suggests how to
connect the programmer, and how to reset the microcontroller while the
flasher waits for connection (grounding the pin CEN). It could take a couple of
attempts because of unstable connections but succeeded eventually.

Now beyond of obvious use of smart switches with Home Assistant, there are a
couple of unique opportunities. First of all, this is an embedded software
platform in an elegant case, connected to WiFi network and conveniently powered
from an AC socket. Second, BK7231N are capable of BLE communications. So
potentially, [esphome-jk-bms](https://github.com/syssi/esphome-jk-bms) could be
ported from ESP32 to create a cheap and convenient battery monitor.

![HA dashboard](/assets/2024-07/ha-dashboard.png)
