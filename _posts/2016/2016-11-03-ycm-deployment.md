---
layout: post
title:  "Compact deployment of YouCompleteMe"
ref:    compact-ycm
lang:   en
date:   2016-11-03 08:45:17 +0200
tags:   vim ycm cpp
---

Intelligent code completion in C++ is best done with
[YouCompleteMe](http://valloric.github.io/YouCompleteMe)
in my opinion. It's fast, precise, clever and easy to install. However,
default installation occupies much space in file system. For example,
after just `python2 install.py --clang-completer`:

![Default space usage]({{ site.url }}/assets/2016-11/ycm-clang.png)

Thus, half of a gigabyte for C#, Go, Rust completion engines, boost and clang
copies. It's a good thing to have self-contained deployment, independent from
specific distribution environment. But I'd like to have more compact
installation.

First step was to use system libclang and boost. This isn't recommended by the
plugin author, by the way. After adding tuning the build to
`python2 install.py --clang-completer --system-libclang --system-boost`:

![Space usage with system libraries]({{ site.url }}/assets/2016-11/ycm-clang-system.png)

Still a quarter of gigabyte. Then drastic cut: implement custom deployment.
The script [update-ycm.sh](https://github.com/sakhnik/dotfiles/blob/master/.bin/update-ycm.sh)
does few things:

 * Clones the latest version of YouCompleteMe from github
 * Builds it with clang completer enabled linking with system libraries
 * Removes fat bits and pieces
 * Deploys the stripped plugin into `~/.vim`
 * Updates global `ycm_extra_conf.py` to match include paths of system clang.

Finally, I like the space usage of what's left:

![Stripped custom deployment]({{ site.url }}/assets/2016-11/ycm.png)

Happy coding!

<!-- vim: set tw=78 spell -->
