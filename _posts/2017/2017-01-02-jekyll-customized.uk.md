---
layout: post
title:  "Пристосування Jekyll для sakhnik.com"
ref:    jekyll-customized
lang:   uk
date:   2017-01-02 14:11:38 +02:00
tags:   web
---

Дві речі було нещодавно додано до сторінок: прапори для зміни мови
у заголовку і розбиття публікацій на сторінки. Щоб цього досягти, мені знадобилося
вивчити ази [Jekyll](https://jekyllrb.com/),
[liquid](http://shopify.github.io/liquid/) і
[Ruby](https://www.ruby-lang.org/en/). Підсумуймо, як це було зроблено.

Для розбиття на сторінки потрібний додаток генерації. Розпочавши з
[існуючого](https://divshot.com/blog/web-development/advanced-jekyll-features/#pagination-with-category),
дуже легко прибрати зайві частини, пристосувати до моїх вимог.
Результуючий додаток доступний у
[github](https://github.com/sakhnik/sakhnik.com/blob/master/_plugins/pagination.rb).
Посилання на сусідні сторінки створюються з допомогою
[pagination.html](https://github.com/sakhnik/sakhnik.com/blob/master/_includes/pagination.html).

З множиною сторінок, попередній спосіб перемикання між мовами став незручним, бо
вже є багато сторінок із заданим `ref`. Тож ми вибираємо тепер тільки перше посилання
на сторінку протилежною мовою. Результат вийшов приємним.

Користуючись нагодою, я змінив кілька шматків коду, щоб уникнути повторень,
наприклад, у сторінках розмітки. Якщо відмінності були тільки у локалізованому тексті,
просто переніс визначення у
[`_config.yml`](https://github.com/sakhnik/sakhnik.com/commit/ecc62ac95bf95e6de2578576d3db7b7ce6b1cebd#diff-aeb42283af8ef8e9da40ededd3ae2ab2R15). Можливо, було б краще тримати їх у місцевих
заголовках (front matter).
