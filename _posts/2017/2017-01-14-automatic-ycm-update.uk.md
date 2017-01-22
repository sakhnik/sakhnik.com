---
layout: post
title:  "Автоматичне оновлення YouCompleteMe"
ref:    automatic-update-of-ycm
lang:   uk
date:   2017-01-14 21:12:59 +02:00
tags:   unix vim
---

Як підтримувати YouCompleteMe працюючим і оновленим після несумісних оновлень
системи (звісно, якщо YCM сам по собі стабільний).

Дві набридливі проблеми можуть статися з [компактним](_posts/2016/2016-11-03-ycm-deployment)
розгортанням YouCompleteMe, коли система поновлюється:

* несумісність `ycmd` з `libclang`, `boost` чи чимось ще
* зміна шляхів до системних заголовків (наприклад `libstdc++`).

У першому випадку розширення не завантажиться взагалі, це легко помітити.
Але в другому випадку деякі функції доповнюються нормально, але тільки не з
стандартної бібліотеки C++. Я щойно збагнув, що YCM міг би поновлюватися разом
із системою, як тільки помічено несумісність.

Дві фіксації ([перша](https://github.com/sakhnik/dotfiles/commit/29ec2327b4c29c612f6427be576983ed0c30081f),
[друга](https://github.com/sakhnik/dotfiles/commit/053e0bd1d584b489e393606fbf073996a122fbb4))
реалізують таке:

* Скрипт [`ycm-check.sh`](https://github.com/sakhnik/dotfiles/blob/master/.bin/ycm-check.sh)
щоб перевіряти, чи всі теки із системними заголовками все ще присутні у файловій
системі, і чи `ycm_core.so` правильно компонується.
* Скрипт [`ycm-update.sh`](https://github.com/sakhnik/dotfiles/blob/master/.bin/ycm-update.sh)
щоб поновлювати розширення і список тек пошуку для `ycm_extra_conf.py`.
* Скрипт [`yaourt`](https://github.com/sakhnik/dotfiles/blob/master/.bin/yaourt)
щоб перехопити запит на поновлення системи.

Тепер щоразу, як я вводжу `yaourt -Syua`, система перевіряє, чи треба поновити
YouCompleteMe, і, власне, поновлює його автоматично.
