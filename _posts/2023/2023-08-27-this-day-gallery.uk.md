---
layout: post
title:  "Цей день у галереї фотографій"
ref:    2023-08-27-this-day-gallery
lang:   uk
date:   2023-08-27 08:20:01 +03:00
tags:   raspberry web media python
---

Якось нещодавно я закинув Google Фотографії на користь pigallery2. Дивіться
попередню статтю про те, як виставити медіа
[галерею]({% post_url /2021/2021-01-09-gallery.uk %}) Shotwell.
Але бракувало ще однієї бажаної функції. Google періодично готує привабливі
підсумки різних подій: що відбувалося цього дня три-п’ять років тому. Але
подумалось, що це не повинно бути надто складно в GNOME Shotwell. Просто вибрати
випадкові фотографії з бази даних, орієнтуючись на дату. Ось як було здійснено
цю ідею.

Передусім, я дослідив функціональність [pigallery2](https://github.com/bpatrik/pigallery2)
і виявив, що він вміє показувати файли розмітки markdown. Тож якщо я б
згенерував такий і розмістив у директорії, його показувало б разом із
фотографіями в тому самому домені. Це дуже спрощує посилання на повнорозмірні
фотографії.

Тоді я витратив трохи часу на кодування мовою Python. Програма проходить по
роках у минуле, скажімо, до 2000. Для кожного року вибирається випадковий набір
фотографій для теперішньої дати, сортується по часу, групується по подіях. І
посилання на вибрані фотографії охайно розміщуються у файл markdown. Раніше код
утримувався в локальному репозиторії [Fossil SCM](https://fossil-scm.org), але
цього разу я експортував його в GitHub для публічності:
[daily.py](https://github.com/sakhnik/shotwell-view/blob/e658f22f4b0f7922d866676b75208ee95d7cc725/daily.py)

Нарешті, можна застосувати таймер systemd (або завдання в cron) щоб запускати
програму щодня зранку. Ось як це зробив я:
[systemd](https://github.com/sakhnik/shotwell-view/commit/649bd67997bfb258dd927522c9e52bb488bda125).

В майбутньому можна ще дещо зробити:

* Витягувати нотатки до фотографій з бази даних Shotwell і показувати їх з допомогою markdown
  у pigallery2
* Потрібно дослідити, як долучати довільні файли як то шляхи GPX до подій у Shotwell.

Як зазвичай, ось ілюстрація результату:

![this day](/assets/2023-08/this-day.jpg)