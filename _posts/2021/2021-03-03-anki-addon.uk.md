---
layout: post
title:  "Перше розширення Anki: дублювати картки у іншу колоду"
ref:    2021-03-03-anki-addon
lang:   uk
date:   2021-03-03 18:45:39 +02:00
tags:   linux python anki
---

Щоб допомогти доньці вивчати англійські слова, кілька років тому я вирішив
спробувати [Anki](https://apps.ankiweb.net/). Програма вельми зменшує витрачені
зусилля і збільшує ефективність, слідкуючи, коли потрібно повторити кожне окреме
слово в будь-якому напрямку: з англійської чи на англійську.
Але коли англійську почала вивчати молодша донька, стало зрозуміло, що було б
добре просто копіювати картки з першої колоди, щоб відслідковувати історію
повторень окремо.
На жаль, не вдалося знайти готове рішення такої, здавалося б, простої задачі:
створити нову картку, скопіювати окремі поля і вкинути її у іншу колоду.
Тож я створив нове розширення для автоматизації таких ручних дій.

Найперше, щоб обійти механізм виявлення дублікатів у Anki, який розпізнає і
позначає однакові слова навіть у різних колодах, потрібно завести новий тип
картки. Цей тип може мати цілком такі самі поля і типи нотаток, але має
називатися по-іншому.

Програма Anki і її розширення розробляються мовою Пітон. Тож слід підготувати
середовище розробки:

```bash
virtualenv /tmp/venv
source /tmp/venv/bin/activate
pip install 'python-language-server[all]'
pip install mypy aqt
```

Розширення завантажуються Anki з `~/.local/share/Anki2/addons21`. У моєму
випадку я просто створив файл `copy_solia/__init__.py` з таким вмістом:

```python
"""."""

import aqt
from aqt import mw
from aqt.utils import tooltip, shortcut
from aqt.qt import QAction


def copy_note(nid):
    """."""
    note = mw.col.getNote(nid)
    model = note.model()
    if model['name'] != "English Yaryna":
        word = note["Front"]
        tooltip(f"Не картка Ярини: {word}", period=2000)
        return
    if 'solia' in note.tags:
        word = note["Front"]
        tooltip(f"Вже скопійовано: {word}", period=2000)
        return

    # Призначити модель до колоди
    solia_deck = mw.col.decks.byName("English:Solia")
    solia_type = mw.col.models.byName("English Solia")
    mw.col.decks.select(solia_deck['id'])
    solia_deck['mid'] = solia_type['id']
    mw.col.decks.save(solia_deck)
    # Призначити колоду до моделі
    mw.col.models.setCurrent(solia_type)
    mw.col.models.current()['did'] = solia_deck['id']
    mw.col.models.save(solia_type)

    new_note = mw.col.newNote()
    new_note.fields = note.fields
    new_note.tags = note.tags
    print(new_note)
    mw.col.add_note(new_note, solia_deck['id'])

    note.tags.append('solia')
    note.flush()


def copy_for_solia(browser):
    """."""
    nids = browser.selectedNotes()
    if not nids:
        tooltip("Не вибрано нотаток.", period=2000)
        return

    # Встановити точку повернення
    mw.progress.start()
    mw.checkpoint("Скопіювати нотатки для Соломії")
    browser.model.beginReset()

    for nid in nids:
        copy_note(nid)

    # Скинути колекцію і головне вікно
    browser.model.endReset()
    mw.progress.finish()
    mw.col.reset()
    mw.reset()
    browser.col.save()


def setup_actions(browser):
    """."""
    action = QAction("Скопіювати для Солі", browser)
    action.setShortcut(shortcut("Alt+D"))
    action.triggered.connect(lambda: copy_for_solia(browser))
    browser.form.menu_Cards.addSeparator()
    browser.form.menu_Cards.addAction(action)


aqt.gui_hooks.browser_menus_did_init.append(setup_actions)
```

І це все. Тепер я можу просто натиснути <alt-d> на вибраних картках, і вони
автоматично продублюються і скопіюються у колоду Солі.
Вже з’явилося кілька нових вимог:

* Розширення повинне дозволяти копіювання у третю колоду, коли наймолодша теж
    розпочне навчання.
* Має бути спосіб синхронізації пов’язаних карток, коли вони еволюціонують.
    Наприклад, коли додаються нові позначки чи приклади після того, як картку
    було продубльовано.

![Знімок екрану Anki із скопійованими картками]({{ site.url }}/assets/2021-03/copy-solia.png)
