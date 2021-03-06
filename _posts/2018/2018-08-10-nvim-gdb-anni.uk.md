---
layout: post
title:  "Перша річниця nvim-gdb"
ref:    2017-08-10-nvim-gdb-anni
lang:   uk
date:   2018-08-10 05:40:43 +03:00
tags:   vim cpp python
---

Перша фіксація у [nvim-gdb]({% post_url /2017/2017-08-20-nvim-gdb %}) сталася 16
серпня 2017 року. Тож можна сміливо відзначати першу річницю.
Проект насправді переріс мої очікування. Тож огляньмо найпомітніші віхи в його
розвитку.


Огляд
-----

Власне, є тільки жменька вимог до налагоджувача:

* Показувати інтерфейс командного рядка налагоджувача
* Показувати початковий код у вікні Vim з позначеним розташуванням активного
    кадру
* Показувати розташування місць зупинки у початковому коді
* Обробляти різні клавіатурні скорочення команд `next`, `step`, `finish`
  тощо.

І nvim-gdb робить тільки це, нічого більше. Припускається, що все інше
підтримується самими налагоджувачем.
Наприклад, збереження місць зупинки, перегляд історії, коду асемблера, реєстрів
процесора, пам’яті і т.ін.


Різні налагоджувачі
-------------------

Все почалося з геніальної тонкої обгортки навколо GDB щоб спростити розробку
Neovim: [neovim_gdb.vim](https://github.com/neovim/neovim/blob/25356f2802b5b98efe7f0d6661979b0a919c4d2d/contrib/gdb/neovim_gdb.vim).
Виявляється, GDB не завжди можна використати
(дивись [запит](https://github.com/sakhnik/nvim-gdb/issues/1#issue-296286720)).
Але та саму ідею можна застосувати до будь-якого налагоджувача з інтерпретатором
команд,— подумалось. — Так, і так з’явилась команда
[`:GdbStartLLDB`]({% post_url 2018/2018-02-16-lldb.uk %}).

Потім, коли велика частина функціональності було вже зроблено мовою Python, мені
знадобилося покроково виконати тест.  Тож довелося на трохи відволіктися і так
само загнуздати PDB.
Хоч він і поводиться трохи по-іншому, все ж цілком можна використовувати.

![Початок PDB]({{ site.url }}/assets/2018-08/pdb-branch.png)


Точні місця зупинки
-------------------

Хоч і легко обробляти натиснення клавіші `<f8>`, зовсім інша справа, коли місце
зупинки визначається в інтерпретаторі команд.  Зупинка може бути тимчасовою
одноразовою, умовною і ще багато якою. До того ж, вона може відповідати багатьом
місцям у коді одночасно.

Щоб показувати значки місць зупинки в початковому коді точно, програма запитує
про це у налагоджувача під час кожної зупинки. Разом з тим, користувачу не можна
набридати неочікуваними повідомленнями, не можна залишати сліди в історії
команд. Усе це по-різному зроблено у різних налагоджувачах.

У LLDB дозволено запустити нитку, у якій виконуються сторонні службові команди
на кшталт `info breakpoints`.  Здається, такої можливості у GDB немає, але
легко обійти історію команд з допомогою префіксу `server`. А взаємодію з ним
можна профільтрувати через тонку програму-посередник. Ось так і вийшло!


Охайний інтерфейс
-----------------

В оригінальному розширенні було дуже легко все зіпсувати. Закрити вікно, перейти
у іншу вкладку під час налагодження тощо. Але тепер все по-іншому.
Поведінку відполіровано. Навіть можна проводити кільки різних сеансів
налагодження одночасно.

Перероблено клавіатурні скорочення. Вони призначаються і прибираються динамічно
залежно від того, в якому вікні фокус. Тож, коли користувач переходить із
вкладки з сеансом налагодження, не можна буде крокувати кодом.  Так само
скорочення nvim-gdb не зіпсують користувацькі скорочення на кшталт
[`ctrl-p`](https://github.com/ctrlpvim/ctrlp.vim).


Набір тестів
------------

Напевне, це найкорисніша частина щоб забезпечити практичну стабільність
розширення. Всі основні операції ретельно тестуються у всіх налагоджувачах.
Тепер можна бути впевненим, що як би не змінився код, зміна не поламає основну
функціональність, поки тести успішні.

```
/tmp/nvim-gdb master
$ ./test/all.sh
Check for neovim     /usr/bin/nvim
Check for python3    /usr/bin/python3
Check for gdb        /home/sakhnik/work/dotfiles/src/.bin/gdb
Check for lldb       /usr/bin/lldb
Compiling test.cpp   a.out
..
----------------------------------------------------------------------
Ran 2 tests in 0.000s

OK
test_10_quit (test_10_generic.TestGdb)
=> Verify that the session exits correctly on window close. ... ok
test_20_generic (test_10_generic.TestGdb)
=> Test a generic use case. ... ok
test_30_breakpoint (test_10_generic.TestGdb)
=> Test toggling breakpoints. ... ok
test_35_breakpoint_cleanup (test_10_generic.TestGdb)
=> Verify that breakpoints are cleaned up after session end. ... ok
test_40_multiview (test_10_generic.TestGdb)
=> Test multiple views. ... ok
test_50_interrupt (test_10_generic.TestGdb)
=> Test interrupt. ... ok
test_10_detect (test_20_breakpoint.TestBreakpoint)
=> Verify manual breakpoint is detected. ... ok
test_20_cd (test_20_breakpoint.TestBreakpoint)
=> Verify manual breakpoint is detected from a random directory. ... ok
test_30_navigate (test_20_breakpoint.TestBreakpoint)
=> Verify that breakpoints stay when source code is navigated. ... ok
test_10_generic (test_30_pdb.TestPdb)
=> Test a generic use case. ... ok
test_20_breakpoint (test_30_pdb.TestPdb)
=> Test toggling breakpoints. ... ok
test_30_navigation (test_30_pdb.TestPdb)
=> Test toggling breakpoints while navigating. ... ok

----------------------------------------------------------------------
Ran 12 tests in 97.445s

OK

/tmp/nvim-gdb master 1m 38s
$
```

Ті самі тести запускаються у Travis CI:
[nvim-gdb](https://travis-ci.org/sakhnik/nvim-gdb).  Зовсім нещодавно було
додано тестування у Darwin, тож тепер неперервна інтеграція здійснюється і у
Linux і в Darwin.
До речі, мені пощастило, що вдалося це зробити без будь-яких дорогих MacOS!

![Travis CI]({{ site.url }}/assets/2018-08/travis.png)


Підсумок
--------

Відверто, мені нечасто потрібен налагоджувач. Проте тепер є один в руках
завжди напоготові. Певна річ, він буде розвиватися. Буде додаватися нова
функціональність, теперішня буде покращуватися.
Будь ласка, не соромтеся повідомляти про помилки чи пропонувати виправлення,
якщо є необхідність.

<script src="https://asciinema.org/a/195787.js" id="asciicast-195787" async></script>
