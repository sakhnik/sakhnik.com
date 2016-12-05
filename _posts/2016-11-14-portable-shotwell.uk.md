---
layout: post
title:  "Переносна бібліотека медія з Shotwell"
ref:    portable-shotwell
lang:   uk
date:   2016-11-14 22:08:36 -05:00
tags:   shotwell portable media
---

[Shotwell](https://wiki.gnome.org/Apps/Shotwell) — це чудовий впорядкувальник фото
GNOME. Він імпортує фотографії у звичну теку `~/Pictures`, зберігає мета інформацію
і образки́ десь глибоко у схованих директоріях. А ось мої вимоги:

* Потрібно зберігати медіафайли на переносному жорсткому диску, тому що мій комп’ютер
може мати обмеженого розміру SSD
* Потрібно тримати мета інформацію і образки́ поблизу фотографії, щоб полегшити створення
резервних копій
* Має бути можливість увіткнути диск у іншу станцію GNOME і колекція фото має бути
готова до використання.

Рішення дуже просте: підмонтувати (bind) директорії з переносного носія у
звичні місця перед запуском Shotwell, і обережно відмонтувати після роботи.

```shell
#!/bin/bash

# Запустити Shotwell у переносній колекції фото

# Вжиток:
#   ./launch-shotwell.sh

set -e

# Припускаємо, що цей скрипт знаходиться у корені переносної теки Pictures
pics_dir=$(readlink -f `dirname ${BASH_SOURCE[0]}`)

echo "Джерельна тека $pics_dir"

cleanup()
{
    echo "$cleanup_actions"
    eval "$cleanup_actions"
}

trap cleanup EXIT

mount_directory()
{
    msg="$1"; src=$2; dst=$3
    echo "Монтуємо $msg з $src"
    mkdir -p $dst
    # Так само можна було б використати bindfs, щоб не вводити пароль адміністратора
    sudo mount -o bind $src $dst
    cleanup_actions="sudo umount $dst; $cleanup_actions"
}

mount_directory "фото" $pics_dir ~/Pictures
mount_directory "база даних shotwell" $pics_dir/shotwell ~/.local/share/shotwell
mount_directory "кеш образків" $pics_dir/shotwell/.cache ~/.cache/shotwell

shotwell
```

Прекрасно, тепер бібліотека медія переживе багато персональних комп’ютерів!
