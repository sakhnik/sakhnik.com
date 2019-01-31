---
layout: post
title:  "Пам’ятка для налаштування свіжого Arch Linux"
ref:    2019-01-05-arch-post-install
lang:   uk
date:   2019-01-05 08:26:58 +02:00
tags:   linux
---

Це список дій, які потрібно виконати на щойно встановленій системі Arch Linux.
Буде постійно уточнюватися.

- Упевнитися, що `discard` серед опцій у `/etc/fstab` для SSD
- Налаштувати планувальник `noop` для необертальних носіїв
    - Зробити його постійним у [tmpfiles](https://github.com/sakhnik/arch-config/blob/e8465b735a75212114595cd2fda979d30702644b/30-hardware.sh#L20)
- Налаштувати прапорці makepkg
    - Дивись приклад із [Кіонії](https://github.com/sakhnik/arch-config/blob/e8465b735a75212114595cd2fda979d30702644b/20-pacman.sh#L77)
- Встановити [yay](https://github.com/Jguer/yay)
    - Або з початкового коду (потребує компілятор Go)
    ([yay<sup>AUR</sup>](https://aur.archlinux.org/packages/yay/))
    - Або вже зібраний
    ([yay-bin<sup>AUR</sup>](https://aur.archlinux.org/packages/yay-bin/))
    - Розглянути необхідність зміни теки збирання: `yay --save --builddir=/tmp -Syu`
- Встановити GNOME із залежностями (як то xorg)
    - Встановити `xf86-video-intel` чи якийсь інший, який потрібно
    - Перевірити запускання gdm, увімкнути його назавжди `sudo systemctl enable
        gdm.service`
- Встановити chromium разом із запропонованими шрифтами TrueType
- Встановити gnome-tweaks
    - Налаштувати бажану поведінку сенсорної панелі
    - Налаштувати тему (темну, світлу)
    - Налаштувати відображення шрифтів (міжпіксельне)
- Встановити [powertop](https://wiki.archlinux.org/index.php/Powertop)
    - Налаштувати споживання електроенергії
- Встановити `networkmanager`, `nm-connection-editor`
- Встановити [systemd-swap](https://github.com/Nefelim4ag/systemd-swap)
    - Налаштувати [витіснення пам’яті](https://wiki.archlinux.org/index.php/Swap#systemd-swap)
- Встановити `openssh`
- Встановити `pacman-contrib`
    - Додати обробники pacman, щоб очищувати схованки пакунків попередніх версій
      після поновлення:
   [paccache-*](https://github.com/sakhnik/arch-config/blob/e8465b735a75212114595cd2fda979d30702644b/20-pacman.sh)
- Обмежити розмір системного журналу
    - Дивись [00-journal-size.conf](https://github.com/sakhnik/arch-config/blob/e8465b735a75212114595cd2fda979d30702644b/40-systemd.sh#L8)
- Встановити і запустити [earlyoom](https://github.com/rfjakob/earlyoom) як
    [earlyoom<sup>AUR</sup>](https://aur.archlinux.org/packages/earlyoom/)
- Налаштувати [tinc](https://wiki.archlinux.org/index.php/Tinc), додати до однієї із мереж
- Налаштувати [прискорення відео](https://wiki.archlinux.org/index.php/Hardware_video_acceleration)
    - Встановити `libva`, `libva-utils`, `libva-intel-driver`
    - Додати користувача до групи `video`
    - Випробувати `vainfo`
- Встановити `pavucontrol`
- Налаштувати мультимедійні клавіші
