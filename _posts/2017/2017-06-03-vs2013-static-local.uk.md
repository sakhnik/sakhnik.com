---
layout: post
title:  "Ініціалізація статичної локальної змінної у VS2013"
ref:    2017-06-03-vs2013-static-local
lang:   uk
date:   2017-06-03 06:54:55 +03:00
tags:   cpp
---

Ось помилка, яку я вивудив нещодавно: статичні локальні змінні не
ініціалізуються потоко-безпечним способом у Visual C++ 2013. Розгляньмо код
ініціалізації об’єкта-одинака:

```C++
Singleton& getInstance()
{
	static Singleton instance;
	return instance;
}
```

C++11 вимагає, щоб компілятори генерували потоко-безпечні інструкції у [цьому
випадку](http://en.cppreference.com/w/cpp/language/storage_duration#Static_local_variables).
Так робить gcc, і таке очікував я. Проте, компілятор Microsoft, здається, ігнорує цю вимогу.
Наприклад, про це говорять на форумі
[gamedev](https://www.gamedev.net/topic/650657-c11-function-local-static-variables-and-multithreading/).
Пильнуйте!
