---
layout: post
title:  "Continuous integration for dotfiles"
ref:    2017-10-17-dotfiles-ci
lang:   en
date:   2017-10-17 08:59:17 +03:00
tags:   linux
---

I've set up [Travis CI](https://travis-ci.org/sakhnik/dotfiles) for
[dotfiles](https://github.com/sakhnik/dotfiles) finally. The idea is to clone
the repository, configure the deployment and to conduct various tests with it.
The most interesting and challenging part is of course testing. To check various
vim functionality in different scenarios automatically,
[PTY](https://en.wikipedia.org/wiki/Pseudoterminal) is required.

It turned out to be simple with Python:
```python
# Run shell in a PTY
master, slave = pty.openpty()
child = subprocess.Popen(['bash'], stdin=slave)

# Feed the child with timed input
for delay, key in InputReader():
    time.sleep(delay)
    os.write(master, bytes(chr(key), 'utf-8'))
```

And there is the showcase:
<script type="text/javascript" src="https://asciinema.org/a/142688.js" id="asciicast-142688" async></script>
