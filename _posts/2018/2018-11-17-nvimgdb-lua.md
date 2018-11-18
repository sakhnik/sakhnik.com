---
layout: post
title:  "Nvim-gdb ported into Moonscript"
ref:    2018-11-17-nvimgdb-lua
lang:   en
date:   2018-11-17 11:18:15 +02:00
tags:   vim cpp
---

[Nvim-gdb]({% post_url /2017/2017-08-20-nvim-gdb %}) queries breakpoints from
the debugger occasionally using a side channel. For that, a unix domain socket
has to be created, bound and connected to the debugger's side channel. So Python
was used to do that. But I realized recently that Neovim has a built-in
interpreter of full-featured Lua. Why not to give it a try? It turned out that
the effort wasn't in vain and resulted in the complete overhaul of the plugin.

## Overview

First of all, Lua happened to be very easy to start. Even though it doesn't
have too much impressive standard library, it's easily extendible with
[Luarocks](https://luarocks.org/). Hence the project has got its own
deployment script
[install.sh](https://github.com/sakhnik/nvim-gdb/blob/56b87294c9959c29ed3605588cea9a95a95f5cb2/install.sh).
It installs luarocks first into a local directory, then a couple of
modules needed to work with regular expressions and POSIX. Finally, it prepares
a compiler of [Moonscript](http://moonscript.org).

Second, I personally don't like the verbosity of Lua, thus, the Moonscript.
It doesn't require you to type keywords constantly, while being concise
and expressive at the same time. Moreover, it's much more pleasant when comes to
object-oriented programming.

So I started gradually substituting Vim script by script with Lua modules,
written in Moonscript.  The effort was successful, and now most of the code has
been ported.

![Language statistics]({{ site.url }}/assets/2018-11/langs.png)

## Details

# Code readability

Moonscript is a conventional expressive programming language. Compare the same
piece of code before and after the porting. It can be spotted instantly that
there is no more silly `let` to assign variables, `call` to invoke a function,
no more declaration junk with `function!` and `endfunction` etc.

![Vim script to Moonscript]({{ site.url }}/assets/2018-11/vim2moon.png)

# Access to the API

Some of Vim workarounds are now completely gone in favour of [Neovim
API](https://neovim.io/doc/user/api.html).
For instance, there is a way to uniquely identify windows, tabpages and buffers.
The handlers can be stored inside the entities, and no more need to jump around
just to get oriented (I refer to the deleted chunk on the above illustration).

# Object orientation

Moonscript allows taking advantage of encapsulation, inheritance and
polymorphism. For instance, debugger-specific backends are now inherited from
the base one. While sharing common state handlers, they allow to change the
state machine transitions.

```moonscript
class PdbScm extends BaseScm
    new: (...) =>
        super select(2, ...)
        @addTrans(@paused, r([[(?<!-)> ([^(]+)\((\d+)\)[^(]+\(\)]]), m, @jump)
        @addTrans(@paused, r([[^\(Pdb\) ]]),                         m, @query)
        @state = @paused
```

# Code decoupling

Refactoring was a good time to reconsider object relations. To make sure that
they interact with each other in a clean and straight forward fashion. As an
illustration, consider how a debugging session is initialized. The standalone
entities `@client`, `@cursor` are initialized first, then those who require them
for functionality, like `@breakpoint` and `@win`. The dependents use their
dependences only through the public interfaces in a controlled manner.

```moonscript
class App
    new: (backendStr, proxyCmd, clientCmd) =>
        -- Create new tab for the debugging view and split horizontally
        V.exe "tabnew | sp"

        -- Enumerate the available windows
        wins = V.list_wins!
        table.sort wins
        wcli, wjump = unpack(wins)

        @backend = require "gdb.backend." .. backendStr

        -- go to the other window and spawn gdb client
        @client = Client(wcli, proxyCmd, clientCmd)

        -- Initialize current line tracking
        @cursor = Cursor()

        -- Initialize breakpoint tracking
        @breakpoint = Breakpoint(@client\getProxyAddr!)

        -- Initialize the windowing subsystem
        @win = Win(wjump, @client, @cursor, @breakpoint)

        -- Initialize the SCM
        @scm = @backend\initScm(@cursor, @win)

        -- The SCM should be ready by now, spawn the debugger!
        @client\start!
```

# Test suite

All the porting was possible thanks to the available test suite.
Equally, the tests were improved too: the execution time was halved, the
reliability increased by eliminating a couple of races.

![Test history in Travis-CI]({{ site.url }}/assets/2018-11/travis-ci.png)

## Conclusions and foresights

- Engaging into overhaul was a good occasion to learn and improve the code base.

- With the updated decoupled code, it should be easier now both to maintain the
    code and to implement new backends, for instance,
    [delve](https://github.com/sakhnik/nvim-gdb/issues/36).

- It's theoretically possible to avoid lua5.1 as a prerequisite, and to use
    Neovim itself as a Lua interpreter for bootstrapping.
