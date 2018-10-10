---
layout: post
title:  "How to fix the WiFi hotspot in Android in the Kyivstar network"
ref:    2018-10-10-android-ap
lang:   en
date:   2018-10-10 23:25:11 +03:00
tags:   android
---

I've discovered that mobile hotspot stopped working right after
[Kyivstar](http://kyivstar.ua) introduced 4G. Android does offer a WiFi access
point, the laptop does connect to it, but no external site can be accessed from
the laptop. It turned out that there was the bug in the
[instructions](https://kyivstar.ua/uk/support/settings/mobile_internet). When a
new APN is created, the type should be `default,dun`. The reference: 
[Quora](https://www.quora.com/I-am-not-able-to-share-internet-through-my-mobile-Moto-G-neither-through-WiFi-nor-through-USB-tethering-What-should-I-do).
