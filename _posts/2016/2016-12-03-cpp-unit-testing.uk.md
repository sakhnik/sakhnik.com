---
layout: post
title:  "Модульне тестування у C++"
ref:    cpp-catch
lang:   uk
date:   2016-12-03 23:44:02 +02:00
tags:   cpp test
---

Я використовував дві бібліотеки у попередніх проектах:
[Boost.Test](http://www.boost.org/doc/libs/1_62_0/libs/test/doc/html/index.html),
[Google Test](https://github.com/google/googletest). Обидва добре підходять
для роботи, але моя теперішня задача потребувала ще простішого інструменту,
особливо стосовно компонування.
Отже, зустрічайте [Catch](https://github.com/philsquared/Catch).

Проблема в тому, що налаштування збірки в Студії Microsoft ще та задача після
зручних автоматизованих систем збирання в лінуксі, як то CMake. Дуже легко
наладнати матрицю збірки у _скриптованому оточенні_. Але це кошмар у
таблицях, деревах властивостей і інших меню Студії.

Оскільки Catch --- це бібліотека, що складається тільки із заголовків, збирання тривіальне:
або покласти заголовок безпосередньо до початкового коду, або просто вказати шлях
до нього у _Additional Include Directories_, один раз для всіх конфігурацій збирання.

Навдивовижу, Catch дуже популярна бібліотека, так само як Google Test на сьогодні: [GTest
чи Catch](https://cpp.libhunt.com/project/googletest-google/vs/catch).

![Google Test чи Catch]({{ site.url }}/assets/2016-12/gtest-vs-catch.png)