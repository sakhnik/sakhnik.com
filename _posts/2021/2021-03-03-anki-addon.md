---
layout: post
title:  "First Anki addon: duplicate cards into another deck"
ref:    2021-03-03-anki-addon
lang:   en
date:   2021-03-03 18:45:39 +02:00
tags:   linux python anki
---

To help my daughter learning English words, I decided to give
[Anki](https://apps.ankiweb.net/) a try a couple of years ago. It greatly
reduces effort and increases efficiency by tracking when to repeat each
individual word in either direction: English to/from Ukrainian. But when a
younger daughter started studying English, I realized that it'd be best to just
copy cards from the first deck to be able to track the review history
separately. Unfortunately, I couldn't find a ready solution for what seemed to
be a very straight forward task: create a new card, copy over individual field
values and toss it to the other deck. So I created a new addon to automate those
manual actions.

First of all, to overcome Anki recognizing the same words even from different
decks as duplicates, it's necessary to introduce a new card type. The card types
may contain exactly the same fields and note types, but should be named
distinctly.

Anki and its addons are developed in Python. So it's worth preparing development
environment:

```bash
virtualenv /tmp/venv
source /tmp/venv/bin/activate
pip install 'python-language-server[all]'
pip install mypy aqt
```

Addons are loaded by Anki from `~/.local/share/Anki2/addons21`. In my case I
just created `copy_solia/__init__.py` with the following content:

> **_NOTE:_**  Created a GitHub repository for the code: [sakhnik/anki-addons](https://github.com/sakhnik/anki-addons)

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
        tooltip(f"Not Yaryna's card: {word}", period=2000)
        return
    if 'solia' in note.tags:
        word = note["Front"]
        tooltip(f"Already copied: {word}", period=2000)
        return

    # Assign model to deck
    solia_deck = mw.col.decks.byName("English:Solia")
    solia_type = mw.col.models.byName("English Solia")
    mw.col.decks.select(solia_deck['id'])
    solia_deck['mid'] = solia_type['id']
    mw.col.decks.save(solia_deck)
    # Assign deck to model
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
        tooltip("No notes selected.", period=2000)
        return

    # Set checkpoint
    mw.progress.start()
    mw.checkpoint("Copy Notes for Solia")
    browser.model.beginReset()

    for nid in nids:
        copy_note(nid)

    # Reset collection and main window
    browser.model.endReset()
    mw.progress.finish()
    mw.col.reset()
    mw.reset()
    browser.col.save()


def setup_actions(browser):
    """."""
    action = QAction("Copy for Solia", browser)
    action.setShortcut(shortcut("Alt+D"))
    action.triggered.connect(lambda: copy_for_solia(browser))
    browser.form.menu_Cards.addSeparator()
    browser.form.menu_Cards.addAction(action)


aqt.gui_hooks.browser_menus_did_init.append(setup_actions)
```

And that's it. Now I can just press <alt-d> on selected cards, and they're
automatically duplicated and copied over to the Solia's deck. There are a
couple of new requirements:

* The addon should allow copying into a third deck when the youngest starts
    studying too
* There should be a way to synchronize related cards as they evolve. For
    example, when new tags or examples are added after a card was duplicated.

![Anki screenshot with copied cards]({{ site.url }}/assets/2021-03/copy-solia.png)
