---
layout: post
title:  "Turning a program into a multistream application"
ref:    2018-09-06-multistream
lang:   en
date:   2018-09-06 06:34:17 +01:00
tags:   cpp
---

Here is a deal: you have a fine-tuned program that is precisely handling one
stream. It uses a dedicated CPU core and busy waiting to achieve sub-millisecond
accuracy. Then you realize that the program just spins the core most of the time
waiting until those tiny bits of work to be executed.  Suboptimal, right? So you
decide to enhance the application to handle multiple such streams by the same
core: let it wait less, but executes more useful work.  Here is how I did this
and the lessons learnt.

# Start

To talk more specifically, consider the main loop of the program:

```c++
void StreamLoop() {
    while (true) {
        auto work = GetNext();
        busyWaitUntil(work.GetTime());
        work.DoIt();
    }
}
```

Please keep in mind that that's way oversimplified, there are multiple stages of
busy waiting within the loop iteration in reality. And the code is legacy,
probably wisely solving a lot of subtle issues. So rewriting it would be the
last thing to consider.

# Preparation

Hey, I thought, I will definitely need to turn the program inside out around
those busy waits. And to use [boost
coroutine2](https://www.boost.org/doc/libs/1_68_0/libs/coroutine2/doc/html/index.html)
instead of calling functions to pass execution flow to and from the stream.
Just like so:

```c++
CoroT::pull_type stream(StreamLoop);  // start the coroutine
auto nextTime = stream.get();  // when to execute it next time

while (true) {
    busyWaitUntil(nextTime);   // wait until the time comes
    stream.pull();             // yield execution to the stream
    nextTime = stream.get();   // update the expectation
}
```

While the stream main loop mostly stays the same, except of the busy waits
turn now into pushes to the main coroutine:

```c++
void StreamLoop(CoroT::push_type yield) {
    while (true) {
        auto work = GetNext();
        yield(work.GetTime());  // <- the only changed line,
                                // yield to the outer loop
        work.DoIt();
    }
}
```

This is rather a straight forward refactoring. A couple of tunings to the build
system, and the code is passing the automatic tests, while being functionally
equivalent.

# Multistream scheduling

Now it's easy to configure the program to handle multiple stream loops. We just
need to decide which stream to execute at every iteration of the outer loop.
Given that we know the supposed execution time, we can use a priority queue as a
schedule.

```c++
struct Task {
    CoroT::pull_type stream;
    TimeT nextTime;

    // Initialize the coroutine
    Task(int): stream(StreamLoop), nextTime(stream.get())
    {}

    // Order by ascending (lower priority first)
    bool operator<(const Task &o) const { return nextTime > o.nextTime; }
};

std::priority_queue<Task> schedule;
for (int i = 0; i < nStreams, ++i) {
    schedule.emplace(i);
}

while (true) {
    auto task = Dequeue(schedule);  // move the earliest task

    busyWaitUntil(task.nextTime);   // wait until the time comes
    task.stream.pull();             // yield execution to the stream
    task.nextTime = task.stream.get();   // update the expectation

    Enqueue(task, schedule);  // reschedule the task
}
```

Again, couple of hours and the tests are passing. Note that the legacy code
still stays untouched!

# Complications

Really, that could be the end of the story. In an ideal world. But in our case
the program wasn't single-threaded. To work around Windows scheduler specifics,
a couple of threads are allocated. The stream loop was running from within these
different threads. One thread 20 ms, the other one 20 ms, than switch back to
the first one etc. In this case the boost coroutines can't be used anymore:
[coroutines and thread
safety](http://www.crystalclearsoftware.com/soc/coroutine/coroutine/threads.html).

It becomes apparent now that the legacy code needs to be changed imminently.
Yet still it can be done accurately. The goal is to refactor the stream loop
function into a stateful functor.

```c++
struct StreamLoop {
    std::function<TimeT()> handler;  // current handler
    WorkT work;                      // automatic variables go here

    StreamLoop() {
        // initial state
        handler = std::bind(&StreamLoop::FirstHalf, this);
    }

    TimeT operator()() {
        return handler();
    }

private:
    TimeT FirstHalf() {
        work = GetNext();
        handler = std::bind(&StreamLoop::SecondHalf, this);
        return work.GetTime();
    }

    TimeT SecondHalf() {
        work.DoIt();
        handler = std::bind(&StreamLoop::FirstHalf, this);
        return TimeT::now();
    }
}
```

# Qualify of service

One compromise to be aware of is the QoS. Since there are a couple of
independent streams being served sequentially, it may happen that their timings
coincide unfortunately. Thus, unwanted delays may be introduced.  This issue can
really be solved by examining the streams more closely. If it's possible to
spread the stream work by choosing initial phase carefully, we are lucky.

# Conclusion

* The task was solved gradually step by step with careful testing between stages
* It's indispensable to have [unit tests]({% post_url 2016/2016-12-03-cpp-unit-testing %})
* While the boost coroutines couldn't be used ultimately, they helped to
    prototype the solution and test the scheduler
* Even when code needs to be reworked, it may still be more practical to
    evolve it instead of starting from scratch.
