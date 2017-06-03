---
layout: post
title:  "Static local variable initialization in VS2013"
ref:    2017-06-03-vs2013-static-local
lang:   en
date:   2017-06-03 06:54:55 +03:00
tags:   cpp
---

There's this bug, which I caught the other day: static local variables aren't
initialized in a thread-safe manner in Visual C++ 2013. Consider the code for
singleton initialization:

```C++
Singleton& getInstance()
{
	static Singleton instance;
	return instance;
}
```

C++11 requires compilers to generate a thread-safe assembly in [this
case](http://en.cppreference.com/w/cpp/language/storage_duration#Static_local_variables).
So does gcc, and so expected I. However, Microsoft compiler seems to ignore this
requirement. For instance, people talk about this on
[gamedev](https://www.gamedev.net/topic/650657-c11-function-local-static-variables-and-multithreading/).
Be careful!
