---
layout: post
title:  "Автоматичне тестування nvim-gdb"
ref:    2018-02-18-nvim-gdb-test
lang:   uk
date:   2018-02-18 08:10:53 +02:00
tags:   vim
---

Почав автоматичне тестування
[nvim-gdb](https://github.com/sakhnik/nvim-gdb) і налаштував неперервну
інтеграцію у [Travis CI](https://travis-ci.org/sakhnik/nvim-gdb). На відміну від
попередньої спроби у [dotfiles]({% post_url /2017/2017-10-17-dotfiles-ci %}),
набагато зручніше скористатися [клієнт
python](https://github.com/neovim/python-client) neovim.

Ось демонстрація наочного режиму:

<script src="https://asciinema.org/a/163642.js" id="asciicast-163642" async></script>
