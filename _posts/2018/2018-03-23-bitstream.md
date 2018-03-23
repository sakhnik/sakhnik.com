---
layout: post
title:  "Bit streams in C++"
ref:    2018-03-23-bitstream
lang:   en
date:   2018-03-23 06:20:29 +02:00
tags:   cpp
---

Reading and writing specific bits is a common task. This article reviews
encountered methods and introduces C++ metaprogramming-style one. There are a
few conventional techniques to do that:

* Apply bitwise operations manually — tedious and efficient
* Use [bit fields](http://en.cppreference.com/w/cpp/language/bit_field) —
    efficient, less tedious, but confusing and hardly portable across platforms
    with different endianness
* Create a custom class that would treat bit streams in run time — there are
    lots of
    [examples](https://www.google.com.ua/search?q=c%2B%2B+bitstream+class) in
    the web.

Here is another way, which is as efficient as manual code, but superb in terms
of convenience. Let the compiler know in advance as much as possible, and it
will be able to generate specific optimized code. Consider the source file
[BitStream.cpp](https://github.com/sakhnik/cpp-sandbox/blob/master/BitStream.cpp).
It defines two template functions:

```c++
// Read 'count' number of bits from a memory starting at bit 'offset'
// The compiler will easily optimize the implementation.
template <unsigned offset, unsigned count>
inline uint32_t Read(const uint8_t *src, uint32_t accum = 0);

// Write given value to the memory starting at 'offset' bit
// spanning 'count' bits
template <unsigned offset, unsigned count>
inline void Write(uint8_t *dst, uint32_t value);
```

For each combination of parameters `offset` and `count`, a specific function is
generated, which is merely few instructions long. And they are natural to use,
for example, consider parsing [RTP](https://tools.ietf.org/html/rfc3550) header:

```c++
const uint8_t *packet = ...;
uint32_t V = Read<0,2>(packet);
uint32_t P = Read<2,1>(packet);
uint32_t X = Read<3,1>(packet);
uint32_t CC = Read<4,4>(packet);
uint16_t seqNum = Read<16,16>(packet);
```

As an illustration, see the generated code in the compiler explorer
([link](https://godbolt.org/g/isqwDW)):

![Reading from bit stream in C++]({{ site.url }}/assets/2018-03/bitstream.png)

One drawback I can think of is the sensitivity of the generated code to
optimizations options. Hence, the debug build may perform quite differently,
which may become noticeable.
