---
layout: post
title:  "Компілювання документів LaTeX на texlive.net"
ref:    2022-08-23-texlive-net
lang:   uk
date:   2022-08-23 20:56:15 +03:00
tags:   latex bash
---

Я щойно усвідомив, що не готовий встановити багато-гігабайтний дистрибутив
TexLive у 32&nbsp;ГБ файлову систему мого ноутбука, переробленого з хромбука.
А мені потрібно іноді поновлювати резюме. На щастя, є веб-служба саме для цього:
[texlive.net](https://texlive.net). Вона виявилася спроможною відобразити моє
[резюме](/assets/sakhnik.pdf) з допомогою XeLaTeX через тестову сторінку, але
так відразу не вийшло, коли я спробував навпростець використати їхній API. Ось
як мені це зрештою вдалося.

Відповідно до їхньої
[документації](https://davidcarlisle.github.io/latexcgi/#http-requests),
параметри потрібно надсилати запитом HTTP POST multipart/form-data. Для цього
зручно застосувати [curl](https://curl.se). І це спрацювало на простих тестових
документах. Але коли я спробував із справжнім резюме, компіляція щоразу була
неуспішною, поки вживався пакунок `hyperref`. Порівняння мережевого перехоплення
Firefox із `curl --trace-ascii`, виявило, що з веб-сторінки надсилається більший
`Content-Length` для практично такої самого набору параметрів. Ага! Напевно,
служба чутлива до формату розділення рядків. Чомусь очікується `\r\n`, а мій файл
було створено із звичним для Unix `\n`.

Тож ось мій скрипт для нотатки:

```bash
#!/bin/bash -e

# Скомпілювати документ xelatex з допомогою API https://texlive.net

name="$1"
texlive="https://texlive.net"

# Компіляція зазнає невдачі, якщо документ не використовує CRLF для розділення рядків
headers=$(curl -s -i \
    -F "filecontents[]=@${name}" \
    -F "filename[]=document.tex" \
    -F "engine=xelatex" \
    -F "return=pdf" \
    ${texlive}/cgi-bin/latexcgi)

location=$(echo "$headers" | grep -Po '(?<=Location: )(/latexcgi/.*?)(?=\r)')

if [[ "$location" == *.pdf ]]; then
    curl -s -Lo ${name/.tex/.pdf} ${texlive}${location}
else
    curl -s -L ${texlive}${location} >&2
    exit 1
fi
```
