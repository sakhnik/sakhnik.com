---
layout: post
title:  "Чудернацька циклічна залежність з модемом 3G"
ref:    2017-05-14-weird-3g
lang:   uk
date:   2017-05-14 08:35:26 +03:00
tags:   win
---

Моєму батькові не вдалося підключити через USB модем
[MiFi 5510L](http://www.nvtl.com/products/mobile-broadband-solutions/mifi-intelligent-mobile-hotspots/mifi-5510l-3g4g-lte-intelligent-mobile-hotspot/): нерозпізнаний пристрій USB.
Вочевидь, потрібно встановити якийсь драйвер. Проте, навряд чи щось особливе
мало бути потрібне для Windows 7, оскільки Novatel окремо пропонує драйвери
тільки для Windows XP. Щоб дозволити системі стягнути з репозиторіїв Microsoft,
потрібне під’єднання до інтернету. Але ж модем має надати з’єднання.
Бачите, потрібно мати робоче з’єднання, щоб під’єднатися. Нечувано!

Проблема розв’язалася, коли ПК спочатку під’єднали через іншого оператора через
інший модем (а саме Kyivstar). Тоді система стягла стандартний драйвер і дозволила
підключити модем 3G через USB.
