---
layout: post
title:  Reserve power
ref:    2023-05-08-reserve-power
lang:   en
date:   2023-05-07 15:00:39 +03:00
tags:   electricity
---


This is the story of how I spent the winter building reserve power sources to
deal with blackouts. When the Russians began to interfere with our power grid,
we started experiencing load shedding. This became a major inconvenience for
our work, our children's studies, and our daily lives. I talked to a friend,
who advised me to use a hybrid solar inverter with a lithium-ion accumulator to
store energy when it's available and then recuperate it during power outages.

## Switching

I purchased a couple of hybrid inverters on AliExpress and waited about a month
for them to arrive. When they finally came, I was visiting my parents and had
to look into the switching panel to figure out how to connect the wires
correctly. There were a couple of different layouts with different inputs
(single-phase, three-phase), available space, and requirements. I did four
installations in total, all very different. But here is the summary of my
experience:

<p align="center" width="100%">
  <img src="/assets/2023-05/reserve-power.svg" width="75%"/>
</p>

This circuit appears to be the most flexible in the required scenarios:

* The grid is online and can power the house including the accumulator charging
* The grid is semi-functional, some phases are missing, yet the house could be powered by one phase
* The grid is off-line, a gasoline generator is used to power the house and store the excessive energy
* The generator is shut down, and the inverter is powering the house using the stored energy.

### Possible combinations

The first switch is a three-pole reserve selection I-0-II. When it's in position I,
the house is connected to the grid directly. When it's in position II, the house
is connected to the reserve power source: generator, inverter output or even a single selected phase.

The second switch is a single-pole selection I-0-II, which can be used to take the power
directly from the selector, or from the inverter output.

The selector is a rotary phase selection plus reserve I-0-II-0-III-0-IV-0. It allows selecting
one phase from the grid or generator output.

So there are multiple use cases of the circuit, but let's consider the most common ones.

### Case 1: power grid is online

This is the normal state when cheap and powerful electricity from the grid is available.
The current flows like before my intervention into the panel. It'll allow
charging the battery by selecting one of the phases and switching on the supply
to the inverter input.

<p align="center" width="100%">
  <img src="/assets/2023-05/reserve-power1.svg" width="75%"/>
</p>

### Case 2: some phases are missing

In case there's some failure in the grid resulting in at least one phase available, the house
could still be powered from the grid. This is suitable if the load is moderate because of
multiple reasons. But yet, just one switch and a selector notch away from powering the whole
house instead of just a part of the house.

<p align="center" width="100%">
  <img src="/assets/2023-05/reserve-power2.svg" width="75%"/>
</p>

### Case 3: generator working, but the inverter is bypassing the power

Although it's possible to use the gasoline generator directly, it's more efficient to
store the excess energy into the battery. The reason is that the internal combustion engine
isn't very scalable, and a significant portion of the fuel is required to just idle it.
Adding more load, of course, will increase fuel consumption, but not necessarily
proportionally. Moreover, the generator requires downtime maintenance: either to just
refuel it or to change the oil and clean the filters.

<p align="center" width="100%">
  <img src="/assets/2023-05/reserve-power3.svg" width="75%"/>
</p>

### Case 4: no external power, the inverter works off the battery

So this is the last resort when nothing else works: no grid, no generator. The inverter doesn't
produce much noise, except for the cooling fans kicking in depending on the actual load.
The limitation here is the capacity of the battery. 120&nbsp;Ah is more than enough to last for
a couple of hours for powering lights, communication, and pumping water occasionally.

<p align="center" width="100%">
  <img src="/assets/2023-05/reserve-power4.svg" width="75%"/>
</p>

## Showcase

### Parent's house

The house is powered by a single phase from the grid.
A DC circuit breaker and Anderson power plug were added later.

![Switching panel](/assets/2023-05/parents0.jpg)
![Inverter](/assets/2023-05/parents1.jpg)

<iframe width="560" height="315" src="https://www.youtube.com/embed/LeAzsSsG7Ps" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

### Parent-in-law's house

Three-phase supply from the grid.
Led batteries were used this time because they require less maintenance than lithium ones,
and the grid electricity was more available at the time. This was the first three-phase
connection and an additional box was needed to host the switches and the selector.

![Overview](/assets/2023-05/parents2.jpg)

<iframe width="560" height="315" src="https://www.youtube.com/embed/gOWEL1YNkFs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

### Our apartment in Kyiv

This one is a one-phase supply. The space was very limited, but still enough to add two components.

![The panel](/assets/2023-05/appartment.jpg)
![The inverter](/assets/2023-05/appartment2.jpg)

<iframe width="560" height="315" src="https://www.youtube.com/embed/AhoMDwEC_s8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

### Cottage house

This time I enjoyed the benefit of available cable from the switcher panel to the utility room.
The electric heater hasn't been used and is unlikely to be utilized in the future.
So I just repurposed the wires.

![Switch panel](/assets/2023-05/house1.jpg)
![Inverter](/assets/2023-05/house2.jpg)

<iframe width="560" height="315" src="https://www.youtube.com/embed/PIUN383YU18" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>


## Portable power source

After two installations, just one inverter was left for two different places.
And I realized at this point, that it's possible to reuse both the inverter and the battery
making them portable. Indeed, it only required four wires to connect the inverter:
AC in, AC out, neutral and protective equipment (earthing). I chose an off-the-shelf
16A 4-wire plug assigning pins in the following way:

| Pin | Wire colour                                | Assignment |
|-----|--------------------------------------------|------------|
| PE  | <span style="color:blue">█</span> blue     | Neutral    |
| 1   | <span style="color:black">█</span> black   | AC in      |
| 2   | <span style="color:yellow">█</span> yellow | PE         |
| 3   | <span style="color:red">█</span> red       | AC out     |

Not only can the inverter be connected to a house via such a plug, but also an extension
cable could be prepared. Now the inverter could power some equipment outdoors
for some time with the charge in the battery, and even allow recharging the battery
from a generator.

![Extension cable](/assets/2023-05/extension.jpg)

## Issues

Special care should be taken of the generator connection. Usually, generators for F-type
plugs allow connecting the load either way N-L or L-N. And this doesn't matter
for appliances. But in our case, it's essential to match neutral and line with the switching
circuit. I haven't looked into what would happen in the case of an incorrect connection.
My mitigation plan so far was to use asymmetric type F plugs, and double
checking the line status with a one-contact test light or non-contact voltage
detector.
