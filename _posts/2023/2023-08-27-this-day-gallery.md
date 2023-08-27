---
layout: post
title:  "This day in photo gallery"
ref:    2023-08-27-this-day-gallery
lang:   en
date:   2023-08-27 08:20:01 +03:00
tags:   raspberry web media python
---

Some time ago, I ditched Google Photos in favour of pigallery2. See, how I
expose Shotwell media [gallery]({% post_url /2021/2021-01-09-gallery %}).
Yet one feature was still left to be wished for. Google prepares appealing
summaries periodically: what happened this day three-five years ago. And it
shouldn't be too complicated in GNOME Shotwell, I thought. Just go and select
random photos from the database based on the date. Here's how this idea was
implemented.

First of all, I researched [pigallery2](https://github.com/bpatrik/pigallery2)
features and discovered that it can render markdown files.
So if I generated one and put into a directory, it'd be served alongside the
photos from the same domain. This simplifies referencing full-resolution photos
a lot.

Then I spent some time coding in Python. The program would iterate over years
into the past until, let's say, the year 2000. For every year, a random set of
photos are selected for the current day, ordered by time, grouped by event. And
the links to the chosen photos with thumbnail previews are carefully laid out
into a markdown file. The code has been kept in a local [Fossil
SCM](https://fossil-scm.org) repository, and this time I exported it to GitHub
for publicity:
[daily.py](https://github.com/sakhnik/shotwell-view/blob/e658f22f4b0f7922d866676b75208ee95d7cc725/daily.py)

Finally, a systemd timer (or a cron job) could be used to run the program each
day early in the morning. Here's how I did it:
[systemd](https://github.com/sakhnik/shotwell-view/commit/649bd67997bfb258dd927522c9e52bb488bda125).

There's more that could be enhanced in the future:

* Notes could be extracted from the Shotwell database and rendered as markdown
  files for pigallery2
* It should be researched how to attach generic files like GPX tracks to the
  events in Shotwell.

As usual, here's an illustration:

![this day](/assets/2023-08/this-day.jpg)
