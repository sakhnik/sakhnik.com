---
layout: post
title:  Liberating Tuya WiFi switch
ref:    2024-07-12-liberate-tuya
lang:   en
date:   2024-07-12 17:32:53 +03:00
tags:   linux iot esphome libretuya
---

I use Home Assistant nowadays to manage electric equipment at home. This is a
remarkable leap forward since my first automation attempts [last year]({%
post_url /2023/2023-01-01-enter-iot %}). I've been using
[ESPHome](https://esphome.io) as custom firmware for Sonoff S26 switches, which
are based on ubiquitous ESP8266. But now it's easier and cheaper to find Tuya
20A switches for as low as 150₴ (under 4$) a piece. They are even equipped with
power meter. But the challenge is that they use LibreTiny chip BK7231N. Here's
what I do.

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
flasher waits for connection (grounding the pin CEN).
