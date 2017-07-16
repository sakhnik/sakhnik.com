---
layout: post
title:  "Власний м’ютекс у C++11"
ref:    2017-07-16-custom-mutex
lang:   uk
date:   2017-07-16 21:56:02 +03:00
tags:   cpp
---

Як запобігти [інверсії
пріоритету](https://en.wikipedia.org/wiki/Priority_inversion) у програмі POSIX?
Pthread дозволяє вибрати протокол
[PTHREAD_PRIO_INHERIT](https://linux.die.net/man/3/pthread_mutexattr_setprotocol)
для м’ютексу. А як цим скористатися у стандартному
[м’ютексі](http://www.cplusplus.com/reference/mutex/mutex/) бібліотеки С++?

Видається цілком прийнятним вивести власний м’ютекс від `std::mutex`,
переініціалізувавши в його основі м’ютекс POSIX у конструкторі. Це не переносний
розв’язок, але стійкість програми понад усе:

```C++
class InheritPrioMutex : public std::mutex
{
    InheritPrioMutex()
    {
        // Знищити робочий м’ютекс
        ::pthread_mutex_destroy(native_handle());

        // Створити атрибут з потрібним протоколом
        ::pthread_mutexattr_t attr;
        ::pthread_mutexattr_init(&attr);
        ::pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
        // Ініціалізувати робочий м’ютекс
        ::pthread_mutex_init(native_handle(), &attr);
        // Атрибут більше не потрібний
        ::pthread_mutexattr_destroy(&attr);
    }
};
```

