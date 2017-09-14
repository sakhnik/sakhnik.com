---
layout: post
title:  "Подолання втрат пам’яті у gnome-shell"
ref:    2017-09-10-gnome-leak
lang:   uk
date:   2017-09-14 22:32:38 +03:00
tags:   systemd
---

У оболонці [GNOME](https://www.gnome.org/news/2017/09/gnome-3-26-released/) тече
пам’ять, псуючи враження від користування. Наприклад, може заморозити ноутбук
постійним підкачуванням. Щоб протистояти, нам доводилося виявляти цю ситуацію,
перемикатися до віртуального терміналу, заходити в систему і убивати схиблений
процес. На щастя, перезапускання gnome-shell майже непомітне і безпечне. Щойно я
збагнув, що нагляд над оболонкою можна легко автоматизувати.

Спочатку ми створюємо дію `~/bin/check-gnome-shell.sh`:

```bash
#!/bin/bash

# Kill any gnome-shell process consuming more than 300 Mb of RAM
ps aux --sort -rss | grep /usr/bin/gnome-shell | awk '{print $2, $6}' | \
    while read -r pid rss; do
        [[ "$rss" -gt 300000 ]] && kill -KILL $pid
    done
```

Потім ми створюємо однозарядну користувацьку службу
`~/.config/systemd/user/check-gnome-shell.service`:

```service
[Unit]
Description=Check whether gnome-shell doesn't leak memory

[Service]
Type=oneshot
ExecStart=/bin/bash /home/sakhnik/bin/check-gnome-shell.sh
```

Потім таймер `~/.config/systemd/user/check-gnome-shell.timer`:

```service
[Unit]
Description=Check whether gnome-shell is leaking memory

[Timer]
OnCalendar=*:0/5

[Install]
WantedBy=timers.target
```

І нарешті ми активуємо і запускаємо таймер:

```bash
systemctl --user enable check-gnome-shell.timer
systemctl --user start check-gnome-shell.timer
```

Це все. Щоп’ять хвилин виконується дія. Вона перевіряє
[зайняту пам’ять](https://en.wikipedia.org/wiki/Resident_set_size) процесів gnome-shell
і вбиває тих, що перебирають 300M.
