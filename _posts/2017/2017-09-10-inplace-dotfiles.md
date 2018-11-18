---
layout: post
title:  "Portable dotfiles"
ref:    2017-09-10-inplace-dotfiles
lang:   en
date:   2017-09-10 07:42:09 +03:00
tags:   vim
---

While [dotfiles](https://github.com/sakhnik/dotfiles) are mainly targeted for
installation into home directory, I realized recently that the settings could be
portable too. Consider the following scenario: a colleague of mine calls me up
for some help, and I will have to look at the code on her station. Local
customizations could be weird and counter-productive. But if instead I deployed
and applied my dotfiles without changing hers, it would be much more convenient.

Luckily, this is easy to achieve by spawning a new shell with `HOME` pointing to
my directory. Also I had to develop a script for automated installation of the
whole zoo of zsh and vim plugins:
[config.sh](https://github.com/sakhnik/dotfiles/blob/4783ec9468554cfb473c257cd0824f566b8b6e8d/config.sh).

<script type="text/javascript" src="https://asciinema.org/a/SqDcy6d1NUBWF6YUuN5vpA3UL.js" id="asciicast-SqDcy6d1NUBWF6YUuN5vpA3UL" async></script>

Supposedly, other applications' options (besides vim) could be supported too.
