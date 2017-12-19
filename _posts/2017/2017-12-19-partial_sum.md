---
layout: post
title:  "A pitfall with std::partial_sum()"
ref:    2017-12-19-partial_sum
lang:   en
date:   2017-12-19 09:56:12 +02:00
tags:   cpp
---

Consider a situation: you get a buffer with some network packets and their
sizes: `void Packetize(std::vector<uint8_t> &buffer, std::vector<uint16_t>
&sizes)`. Now to send the packets out, you need to calculate packet offsets.
What could be easier with STL:

```c++
std::vector<uint32_t> offsets(sizes.size() + 1);
offsets[0] = 0;
std::partial_sum(sizes.begin(), sizes.end(), offsets.begin() + 1);
```

The code is simple, elegant, builds and works well while your buffer is less
than 64K. But then you discover that for the bigger buffers, the offsets aren't
monotonic. Right, the function
[partial_sum](http://www.cplusplus.com/reference/numeric/partial_sum/)
accumulates into a variable of type of the input iterator!

So either you should ensure that the `sizes` are stored as a sufficiently
large integers (for instance, `uint32_t`) or use Boost's `transform_iterator`:

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
