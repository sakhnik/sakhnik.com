---
layout: post
title:  "Контейнери Linux з systemd-nspawn"
ref:    systemd-nspawn
lang:   uk
date:   2016-11-28 22:27:49 +02:00
tags:   linux virt systemd
---

Коли мені був потрібен певний дистрибутив на сучасній станції лінукс, я вживав
[schroot](https://wiki.archlinux.org/index.php?title=Install_bundled_32-bit_system_in_64-bit_system&redirect=no#Schroot).
Більш продуманим рішенням було б використовувати
[LXC](https://wiki.archlinux.org/index.php/Linux_Containers). Проте на тій самій
сторінці радять
[systemd-nspawn](https://wiki.archlinux.org/index.php/Systemd-nspawn) як альтернативу.
Тож я вирішив спробувати її нещодавно, коли потрібно було приготувати CentOS 7
для роботи.

Встановлення просте: просто отримати дерево кореневої файлової системи. Потрібно було
виправити недоступність директорії `/tmp/.X11-unix` з контейнера --- зв’язав явно
з не-tmpfs. Створив стартовий скрипт, щоб було зручно запускати систему:
```bash
#!/bin/bash

cur_dir=`readlink -f $(dirname ${BASH_SOURCE[0]})`

xhost +local:

# Зауважте, що --bind /tmp/.X11-unix насправді не зберігає сокети,
# краще їх передати через /w

sudo systemd-nspawn \
    -D $cur_dir/centos \
    -b \
    -n \
    --bind /w \
    --bind /home/sakhnik
```

Результат вражаючий. Система «завантажується» в термінал входу:

![Завантажений CentOS 7]({{ site.url }}/assets/2016-11/systemd-nspawn.png)

Я використав віртуальне локальне з’єднання до мережі в контейнері з допомогою
`systemd-networkd`:

![Конфігурація мережі]({{ site.url }}/assets/2016-11/systemd-nspawn2.png)

Поки що добре. Подивімося пізніше, наскільки цей контейнер придатний для роботи.
