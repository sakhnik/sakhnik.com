---
layout: post
title:  "The first anniversary of nvim-gdb"
ref:    2017-08-20-nvim-gdb-anni
lang:   en
date:   2018-08-10 05:40:43 +03:00
tags:   vim cpp python
---

The first commit to [nvim-gdb]({% post_url /2017/2017-08-20-nvim-gdb %})
happened the 16th of August, 2017. So I may safely assume that it's the
first anniversary. The project has grown beyond my expectations really. So let's
review most notable milestones in its development.


Overview
--------

Essentially, there is only a handful of requirements to a debugger plugin:

* Show the backend CLI
* Show source code with current frame location in a Vim window
* Show breakpoint locations in the source code
* Handle various short keys for the debugger commands `next`, `step`, `finish`
  etc.

And the nvim-gdb does exactly that, but no more. It is assumed that all the
other features are supported by the debugger backend. Like saving breakpoints,
reviewing debugging history, assembly, registers, memory, you name it!


Diverse backends
----------------

It started as a ingenious thin wrapper around GDB to facilitate development of
Neovim: [neovim_gdb.vim](https://github.com/neovim/neovim/blob/master/contrib/gdb/neovim_gdb.vim).
 It turns out that GDB isn't always
available (see the [feature
request](https://github.com/sakhnik/nvim-gdb/issues/1#issue-296286720)).
But the same idea could be applied to any CLI debugger, I thought. —Yes, and thus
[`:GdbStartLLDB`]({% post_url 2018/2018-02-16-lldb %}) was introduced.

Then later on, when much of functionality was implemented in Python already, I
needed to step through the test. So I step aside for a short time, and got PDB
harnessed too. Although it behaves a little bit differently, yet still it's
completely usable.

![Inception of PDB]({{ site.url }}/assets/2018-08/pdb-branch.png)


Accurate breakpoints
--------------------

While it's easy to handle user hitting `<f8>`, it's not so easy when a
breakpoint is set with a CLI command. One can setup a one-hit temporary
breakpoint, a conditional breakpoint and a lot more. And a breakpoint may
resolve to multiple places in the source code.

To show breakpoint signs in the source code accurately, the plugin would query
breakpoint locations for the current file on every stop. On the other hand, the
user should be annoyed with unexpected debugger output, and the debugging
history should be rather untouched. It's done separately for different backends.

LLDB allows to spawn a thread, which would run a side channel for commands
service commands like `info breakpoints`.  GDB doesn't seem to allow that, but
it's easy to bypass command history with prefix `server`. And the interaction
with it can be filtered out with a wrapper proxy application. So that's how it
worked out!


Careful UI
----------

It was really easy to mess beyond reparation in the original plugin. Close a
window, go to another tab while debugging etc.


Test suite
----------

TBD

Continuous integration in Darwin.


Wrap up
-------

Frankly speaking, I don't use the debugger that often.
