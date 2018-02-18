---
layout: post
title:  "Automatic testing of nvim-gdb"
ref:    2018-02-18-nvim-gdb-test
lang:   en
date:   2018-02-18 08:10:53 +02:00
tags:   vim
---

Started doing automatic testing of
[nvim-gdb](https://github.com/sakhnik/nvim-gdb) and configured continuous
integration with [Travis CI](https://travis-ci.org/sakhnik/nvim-gdb). Unlike the
previous attempt with [dotfiles]({% post_url /2017/2017-10-17-dotfiles-ci %}),
it's more convenient to use neovim [python
client](https://github.com/neovim/python-client).

Here is the showcast of the visual mode:

<script src="https://asciinema.org/a/163642.js" id="asciicast-163642" async></script>
