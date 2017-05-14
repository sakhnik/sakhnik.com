---
layout: post
title:  "Weird cyclic dependency with 3G modem"
ref:    2017-05-14-weird-3g
lang:   en
date:   2017-05-14 08:35:26 +03:00
tags:   win
---

My father experienced troubles trying to tether
[MiFi 5510L](http://www.nvtl.com/products/mobile-broadband-solutions/mifi-intelligent-mobile-hotspots/mifi-5510l-3g4g-lte-intelligent-mobile-hotspot/): unrecognized USB device.
Apparently, a driver was needed to be installed. However, no specific driver
should be required for Windows 7, because Novatel offers custom ones only for
Windows XP. Letting the system to download one from Microsoft repositories
needed a working internet connection. But that's the modem who should provide a
connection. You see, you need to be connected to become connected. Hilarious!

The problem solved when the PC was first connected using a different provider
via a different modem (specifically, Kyivstar). The system was able to download
a standard driver and allow tethering the 3G modem via USB.
