---
layout: post
title:  "Beating memory leak of gnome-shell"
ref:    2017-09-10-gnome-leak
lang:   en
date:   2017-09-14 22:32:38 +03:00
tags:   systemd
---

[GNOME](https://www.gnome.org/news/2017/09/gnome-3-26-released/) shell has been
leaking memory for a while hurting user experience. For instance, it could
freeze a laptop sending it to deep swapping. To counteract, we had to detect the
situation, switch to the virtual terminal, login and kill the offending process.
Luckily, restarting gnome-shell is seamless and harmless. I have just realized
that monitoring it could easily be automated.

First, we create the action `~/bin/check-gnome-shell.sh`:

```bash
#!/bin/bash

# Kill any gnome-shell process consuming more than 300 Mb of RAM
ps aux --sort -rss | grep /usr/bin/gnome-shell | awk '{print $2, $6}' | \
    while read -r pid rss; do
        [[ "$rss" -gt 300000 ]] && kill -KILL $pid
    done
```

Then we create a one-shot user service
`~/.config/systemd/user/check-gnome-shell.service`:

```service
[Unit]
Description=Check whether gnome-shell doesn't leak memory

[Service]
Type=oneshot
ExecStart=/bin/bash /home/sakhnik/bin/check-gnome-shell.sh
```

Then comes the timer `~/.config/systemd/user/check-gnome-shell.timer`:

```service
[Unit]
Description=Check whether gnome-shell is leaking memory

[Timer]
OnCalendar=*:0/5

[Install]
WantedBy=timers.target
```

And finally, we enable and start the timer:

```bash
systemctl --user enable check-gnome-shell.timer
systemctl --user start check-gnome-shell.timer
```

And that's all. Every 5 minutes the action is executed. It checks
[RSS](https://en.wikipedia.org/wiki/Resident_set_size) of gnome-shell processes,
and kills those occupying more than 300M.
