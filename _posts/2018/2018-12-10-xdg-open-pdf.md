---
layout: post
title:  "Fix PDF opened in GIMP by default"
ref:    2018-12-10-xdg-open-pdf
lang:   en
date:   2018-12-10 21:53:14 +02:00
tags:   linux
---

When Arch linux is used without a specific desktop environment like GNOME or
KDE, opening a file by `xdg-open` works incorrectly. Particularly, GIMP is
launched for PDF instead of a dedicated viewer. There are some details on the
Arch wiki page
[xdg-utils](https://wiki.archlinux.org/index.php/Xdg-utils#xdg-open). To fix the
issue, it's necessary to install another application association handler.

Looking at the comparison table on the page [Default
applications](https://wiki.archlinux.org/index.php/Default_applications#mimeo),
I decided to install
[`mimeo`](https://wiki.archlinux.org/index.php/Default_applications#mimeo) and
`xdg-utils-mimeo`.
Then to make sure Evince is launched to view a PDF file, did the following:

- `mimeo -d` to list available desktop entries
- `mimeo --add application/pdf org.gnome.Evince.desktop` to set the default
    application
- `mimeo /tmp/test.pdf` to ensure the document is opened in Evince.
