---
layout: post
title:  "Як виправити, щоб PDF відкривався не в GIMP"
ref:    2018-12-10-xdg-open-pdf
lang:   uk
date:   2018-12-10 21:53:14 +02:00
tags:   linux
---

Коли Arch linux використовується без інтегрованого середовища як то GNOME чи
KDE, відкриття файлу з допомогою `xdg-open` працює неправильно. Зокрема, замість
специфічного оглядача документів PDF запускається GIMP.
Трохи деталей на сторінці вікі Arch
[xdg-utils](https://wiki.archlinux.org/index.php/Xdg-utils#xdg-open). Щоб
виправити проблему, треба встановити іншого обробника асоціацій програм.

Подивився на порівняльну таблицю на сторінці [Default
applications](https://wiki.archlinux.org/index.php/Default_applications#mimeo),
і вирішив вибрати
[`mimeo`](https://wiki.archlinux.org/index.php/Default_applications#mimeo) і
`xdg-utils-mimeo`.
Щоб переконатися, що для перегляду файлу PDF запускається Evince, зробив таке:

- `mimeo -d` щоб перелічити можливі програми
- `mimeo --add application/pdf org.gnome.Evince.desktop` щоб встановити основну
    програму для PDF
- `mimeo /tmp/test.pdf` щоб переконатися, що правильну програму вибрано.
