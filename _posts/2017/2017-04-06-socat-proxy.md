---
layout: post
title:  "Quick and dirty socat proxy"
ref:    2017-04-06-socat-proxy
lang:   en
date:   2017-04-06 07:09:45+03:00
tags:   unix
---

Here is the situation: a windows machine has VPN connection to a development
service (for instance, HTTP sever), and we'd like to use it from another
machine, which doesn't have VPN credentials ready. So there is a little trick to
get things running in a minute just using socat.

```
# socat tcp-listen:80,fork tcp:dev.company.com:80
```

Now you just point the third machine to your station and the build is working.
Out of [options
available](https://www.google.com.ua/search?q=tcp+forwarding+unix), this one is
particularly convenient: works on Windows, easy and safe.
