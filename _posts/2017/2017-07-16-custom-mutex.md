---
layout: post
title:  "Custom mutex in C++11"
ref:    2017-07-16-custom-mutex
lang:   en
date:   2017-07-16 21:56:02 +03:00
tags:   cpp
---

How to avoid [priority
inversion](https://en.wikipedia.org/wiki/Priority_inversion) in a POSIX program?
Pthread allows to choose the protocol
[PTHREAD_PRIO_INHERIT](https://linux.die.net/man/3/pthread_mutexattr_setprotocol)
on a mutex. And how to use this feature in a standard C++
[mutex](http://www.cplusplus.com/reference/mutex/mutex/)?

It seems feasible to derive a custom mutex from `std::mutex`, while
reinitializing the underlying POSIX mutex in the constructor. That's a
non-portable hackery, yet program stability should prevail:

```C++
class InheritPrioMutex : public std::mutex
{
    InheritPrioMutex()
    {
        // Destroy the underlying mutex
        ::pthread_mutex_destroy(native_handle());

        // Create mutex attribute with desired protocol
        ::pthread_mutexattr_t attr;
        ::pthread_mutexattr_init(&attr);
        ::pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
        // Initialize the underlying mutex
        ::pthread_mutex_init(native_handle(), &attr);
        // The attribute shouldn't be needed any more
        ::pthread_mutexattr_destroy(&attr);
    }
};
```
