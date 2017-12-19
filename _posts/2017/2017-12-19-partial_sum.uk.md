---
layout: post
title:  "Пастка з std::partial_sum()"
ref:    2017-12-19-partial_sum
lang:   uk
date:   2017-12-19 09:56:12 +02:00
tags:   cpp
---

Розгляньмо ситуація: у вас є буфер із якимись мережевими пакетами і їхні
розміри: `void Packetize(std::vector<uint8_t> &buffer, std::vector<uint16_t>
&sizes)`. Тепер щоб надіслати ці пакети, вам потрібно обрахувати зміщення.
Що може бути простіше із STL:

```c++
std::vector<uint32_t> offsets(sizes.size() + 1);
offsets[0] = 0;
std::partial_sum(sizes.begin(), sizes.end(), offsets.begin() + 1);
```

Код простий, елегантний, збирається і працює добре поки ваш буфер менший 64 Kб.
Але потім ви виявите, що для більших буферів зміщення пакетів не зростають
монотонно.
Так, функція
[partial_sum](http://www.cplusplus.com/reference/numeric/partial_sum/)
накопичує у змінну, яка має тип значення вхідного ітератора!

Тож або ви маєте переконатися, що `sizes` збережено у достатньо широкому типі
(наприклад, `uint32_t`), або використати `transform_iterator` з Boost:

```c++
std::vector<uint32_t> offsets(sizes.size() + 1);
offsets[0] = 0;

struct Cast
{
    uint32_t ToUint32(uint16_t v) { return v; }
};

std::partial_sum(boost::make_transform_iterator(sizes.begin(), Cast::ToUint32),
                 boost::make_transform_iterator(sizes.end(), Cast::ToUint32),
                 offsets.begin() + 1);
```
