---
layout: post
title:  Hello Meshtastic
ref:    2025-04-26-hello-meshtastic
lang:   en
date:   2025-04-26 16:18:34 +03:00
tags:   radio meshtastic
---

A couple of weeks ago, my 9-year daughter got lost in a forest during an
orienteering training session. It happens sometimes, and children are assumed to
follow the predefined algorithm to return to the base. But something was off
this time: she didn't take a compass or a phone with her. Neither could I locate
her following the planned route. Luckily, she was able to focus and return by
herself, although a tired more than usual. So there came an idea to me. An
electronic tracker could help locate younger students and spare our rescuing
efforts. Quick research showed that there are different options for a 'GPS
Tracker'.

Here are my requirements:

  - GPS/GNSS receiver for precise geolocation
  - LoRa radio for telemetry
  - Basic screen with directions to other nodes relative to the north, sun or moon
  - Battery power for ~10 hour autonomy.
  - Affordable cost

Of course, a smartphone is a viable option, despite it's impractical to carry
on a training course, and the cellular service isn't everywhere available in the
forests. So a purposed gadget, designed to be carried as a necklace would be
much more preferable.

My choice is [Heltec Wireless
Tracker](https://heltec.org/project/wireless-tracker/), which costs ~20$. I
figured out how to draw shapes and print text on the display, how to receive
geolocation coordinates, how to transmit and receive through the LoRa radio.
But then I realized that there's no need to develop my own system because
[Meshtastic](https://meshtastic.org/) already offers everything I need. It's a
communication system primarily, but it allows sharing and displaying precise
location of the neighbour nodes on the map in a private channel. It already has
mobile app, a convenient infrastructure for maintenance and support.

So the only thing left for me was to order and package some 2000&nbsp;mAh LiPo
battery and create an enclosure. I did it with OpenSCAD this time:
[repo](https://github.com/sakhnik/heltec-wireless-tracker). The total cost
turned out to be ~1000 ₴.

![Case model](/assets/2025-04/case-model.png)

![Tracker](/assets/2025-04/tracker.jpg)

Meshtastic is an open source project, so it can be customized for our use case.
For example, to display the direction to the sun and the moon to help navigation
when the compass isn't available.

References:

  - [Meshtastic in Ukraine](https://ut3usw.dead.guru/docs/ham/meshtastic/)
  - [Meshtastic pet tracker](https://gorges.us/meshtastic-pet-tracker/) — similar story and application
