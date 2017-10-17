---
layout: post
title:  "Неперервна інтеграція для файлів налаштунків"
ref:    2017-10-17-dotfiles-ci
lang:   uk
date:   2017-10-17 08:59:17 +03:00
tags:   linux
---

Нарешті налаштував [Travis CI](https://travis-ci.org/sakhnik/dotfiles) для
[крапка-файлів](https://github.com/sakhnik/dotfiles). Задум простий: склонувати
репозиторій, сконфігурувати і провести різні тести над ним.
Найцікавішою і найскладнішою частиною є, безумовно, тестування. Щоб перевірити
різноманітну функціональність vim у різних сценаріях автоматизовано,
потрібно залучати
[псевдотермінал](https://uk.wikipedia.org/wiki/%D0%9F%D1%81%D0%B5%D0%B2%D0%B4%D0%BE%D1%82%D0%B5%D1%80%D0%BC%D1%96%D0%BD%D0%B0%D0%BB).

Виявилося, це дуже просто з Пітоном:
```python
# Запустити оболонку у псевдотерміналі
master, slave = pty.openpty()
child = subprocess.Popen(['bash'], stdin=slave)

# Надсилати клавіші у дочірній процес з правильними затримками
for delay, key in InputReader():
    time.sleep(delay)
    os.write(master, bytes(chr(key), 'utf-8'))
```

Ось демонстрація:
<script type="text/javascript" src="https://asciinema.org/a/142688.js" id="asciicast-142688" async></script>
