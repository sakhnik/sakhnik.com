---
layout: post
title:  "Compiling LaTeX documents on texlive.net"
ref:    2022-08-23-texlive-net
lang:   en
date:   2022-08-23 20:56:15 +03:00
tags:   latex bash
---

I've just realized that I'm not ready to install a multi-gigabyte TexLive
distribution in the 32&nbsp;GB file system of my Chromebook-based laptop.
And I need to update the CV sometimes. Luckily, there's a web service available
exactly for that: [texlive.net](https://texlive.net). It turned out capable of
rendering my CV using XeLaTeX via their test web page, but it didn't work
immediately when I tried using their API directly. Here's how I did that
eventually.

According to their
[documentation](https://davidcarlisle.github.io/latexcgi/#http-requests), the
parameters need to be sent in an HTTP POST multipart/form-data request. It's
convenient to employ [curl](https://curl.se) to do the job. And it worked on simple
test documents. But when I tried with the real CV, the compilation failed
consistently while using the package `hyperref`. Comparison of the Firefox network
capture with `curl --trace-ascii` revealed that the test web page sends
bigger `Content-Length` for practically the same parameter set. Aha! The
service must be sensitive to the line endings format. It expects `\r\n` for some
reason, and my file was authored using Unix convention with just `\n`.

So there's my script to note:

```bash
#!/bin/bash -e

# Compile xelatex document using the API of https://texlive.net

name="$1"
texlive="https://texlive.net"

# The compilation will fail if the document doesn't use DOS line endings CRLF
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
