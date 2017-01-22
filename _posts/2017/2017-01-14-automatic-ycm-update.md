---
layout: post
title:  "Automatic update of YouCompleteMe"
ref:    automatic-update-of-ycm
lang:   en
date:   2017-01-14 21:12:59 +02:00
tags:   unix vim
---

How to keep YouCompleteMe functional and updated after breaking system
updates (of course, if YCM is itself stable).

Two annoyances may happen with [compact](_posts/2016/2016-11-03-ycm-deployment)
YouCompleteMe deployment when a system gets updated:

* `ycmd` incompatibility with `libclang`, `boost` or anything else
* system include paths change (mind `libstdc++`).

In the first case the plugin wouldn't load at all, it's easily noticeable.
But in the second case some functions are completed, but not standard C++.
I've just realized that YCM could be updated with the system too as soon as
incompatibility is detected.

Two commits ([first](https://github.com/sakhnik/dotfiles/commit/29ec2327b4c29c612f6427be576983ed0c30081f),
[second](https://github.com/sakhnik/dotfiles/commit/053e0bd1d584b489e393606fbf073996a122fbb4))
implement the following:

* The script [`ycm-check.sh`](https://github.com/sakhnik/dotfiles/blob/master/.bin/ycm-check.sh)
to check whether all the system include directories are still accessible in the
file system, and to check whether `ycm_core.so` links properly.
* The script [`ycm-update.sh`](https://github.com/sakhnik/dotfiles/blob/master/.bin/ycm-update.sh)
to update the plugin and include directories for `ycm_extra_conf.py`.
* The script [`yaourt`](https://github.com/sakhnik/dotfiles/blob/master/.bin/yaourt)
to hook into system update request.

Now every time I type `yaourt -Syua`, the system checks whether YouCompleteMe
needs be updated, and does the update automatically.
