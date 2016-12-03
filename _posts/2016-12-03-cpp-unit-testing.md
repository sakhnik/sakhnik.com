---
layout: post
title:  "Unit testing in C++"
date:   2016-12-03 23:44:02 +02:00
tags:   cpp test
---

I tried two frameworks in the previous projects:
[Boost.Test](http://www.boost.org/doc/libs/1_62_0/libs/test/doc/html/index.html),
[Google Test](https://github.com/google/googletest). Both of them fit well to
the job, but my current task called for a simpler tool, especially concerning
linking. Hence meet [Catch](https://github.com/philsquared/Catch).

The problem is that setting up build in Microsoft Visual Studio is challenging
after convenience of Linux automated build systems like CMake. It's easy to
tune up matrix builds in a _scripted environment_. But that's a nightmare in
property sheets, trees and menus of the Studio.

Since Catch is header only library, the build is trivial: either throw the
header under feet, or just point to it in _Additional Include Directories_,
once for all build configurations.

Surprisingly, Catch is very popular, keeps up with Google Test today: [GTest
vs Catch](https://cpp.libhunt.com/project/googletest-google/vs/catch).

![Google Test vs Catch]({{ site.url }}/assets/2016-12/gtest-vs-catch.png)
