---
layout:   post
title:    "Learning with Tests: Part II"
date:     2021-02-17 10:00:00 +0100
tag:      programming
summary:  "\"Testing the documentation\", the practice of incrementally build a living artifact of the the programming language documentation."
---

> *"Testing the documentation"*, the practice of incrementally build a living artifact of the the programming language documentation.

<!--more-->

This is the second part of the series where I tell you about my experience in learning a new programming language with the support of tests.

In [part I]({% post_url 2020-07-26-learning-with-tests-part-one %}) we saw how small actions like:

- Being able to **compile** a code.
- Being able to **write and run** tests.

Allowed us to grow enough confidence with the tools, with the testing library, and also have a first practical contact with the new programming language.

We are settled!

Now we have an environment we can use to run small experiments, it's time to dive in, and explore the programming language looking at its documentation, and start taking a few *"pictures"* of it!

## "Testing the documentation"

This is the part where we go through the documentation of the programming language as we usually do when trying to learn something about it. Nothing particularly exciting so far.

From time to time, some documentations offer a set of exercises to do at the end of each section. The same applies to books. Lately, different online documentation offers REPL functionality, where we can try the code within an online console.

My practice is to not expect this kind of interactivity from the documentation, or the book I am reading. Exercises and online REPL are and extra and unexpected things.

Instead, I like to create rooms for practicing on what I read through the documentation. Whenever I read something that catches my attention, such as dealing with data structures, playing with list, arrays, other data types, something specific for that programming language, and so on, I like to stop myself for a moment and try to write small tests that describe the behavior I am more interested in.

I will give you an example. Suppose we want to play with something related to arrays and their companion functions to deal with them (e.g. ordering, searching, inserting, and whatever.)

In that case, I want to write a test that describe that I can order an unordered array of numbers:

```
it "can order an array of unordered numbers" do
  myArray = [1,4,5,2,3]

  myOrderedArray = sort(myArray)

  assert [1,2,3,4,5] == myOrderedArray
end
```

This is a pseudo-code, but by writing a small test, instead of just taking from grant the documentation, we have done a few interesting things:

- Reduced the scope of learning by writing a test for it.
- Created a live documentation of the language.

And we are not done. We see that this test will pass quickly.

There is nothing to implement, we are just using a built-in function of the language (`sort(array)`), but we can try to learn more about the test library:

**Is there a test helper that can help to check that an array is sorted?**

An probably we will find it, `Arrays.is_ordered`!

```
it "can order an array of unordered numbers" do
  myArray = [1,4,5,2,3]

  myOrderedArray = sort(myArray)

  assert Arrays.is_ordered(myOrderedArray)
end
```

As I wrote before, every time we write down a test for what we are learning we are narrowing down the scope. We keep the focus only on one particular aspect of the language. In this case, we start questioning about **sorting functionalities!**

## Where is my red bar?

When using a test-first approach in computer programming, the test is often expected to fail, at first. We first write the test, and only after we proceed to write the enough amount of code needed to make it pass.

Red -> Green -> Refactor

In the *sorting* example, there was no red bar, since everything was already available and we were just exploring the language built-ins.

Let's have an example where we can use tests as a guiding force in learning something specific about the programming language, going through the micro-cycle of red-green-refactor.

## When I was learning Elixir

During my journey in learning Elixir, I used to follow the same approach I am describing here. While I was *"testing the documentation"*, one of the topics that caught my attention was the one related to the [Processes](https://elixir-lang.org/getting-started/processes.html).

Processes in Elixir represent the fundamental element on which our code is executed. They are isolated from each other, and they communicate by sending messages. Building a distributed and fault-tolerance system is all about dealing with processes.

There a few questions I wanted to address and then, understand how to describe by using tests:

1. How to start a process?
2. How to send and receive messages?
3. How to use processes to keep state?

Using a [TODO list]({% post_url 2020-07-08-todo %}) here can be of great benefit to keep track of the things we want to learn. You can see how different practices can play together to enhance the process of learning.

### How to start a process?

Going through the documentation I learned that `spawn` is the function used to start a new process, and then a utility function `Process.alive?(pid)` is used to check if a process is up and running. With this basic notion in mind I tried to put everything together, and use a test as *live documentation*:


```elixir
defmodule MyProcess do
  def loop() do
    receive do
      _ -> loop()
    end
  end
end

test "run a process" do
  pid = spawn(MyProcess, :loop, [])

  assert Process.alive?(pid)
end
```

There is no rocket science in here, but this test helped me to learn at least four things, in a very practical way:

- How to define a simple `loop` function for a process that does nothing.
- How to start a process with `spawn`.
- That every time a process starts, its `pid` is returned.
- How to check if a process is running, with `Process.alive?(pid)`.

With this test, I draw the basis to proceed and find the answers to the next two questions.

### How to send and receive messages?

An interesting part of processes is that they communicate by sending and receiving messages. As I did for the previous step, I wanted to create a new test that allowed me to learn practically this mechanism:


```elixir
defmodule MyProcess do
  def loop() do
    receive do
      {from, :greet} ->
        send(from, "Hello world!")
        loop()

      _ ->
        loop()
    end
  end
end

# ...

test "returns 'Hello world!' when receive :greet" do
  pid = spawn(MyProcess, :loop, [])

  send(pid, {self(), :greet})

  assert_receive "Hello world!"
end
```

There is a little but important detail that this test helped me comprehend better: if a process wants to return something (in our example the string "Hello world!"), it needs to send a message back to the process which sent the original message (in our example is the test itself)!

As happened with the previous test, now I learned a few more things:

- The use of `self()` returns the `pid` of the current process.
- The built-int `assert_receive` can be used to test that a message is received.
- How to extend the `receive` block to handle a new message and reply.

### How to use processes to keep state?

This was the last question I had to learn about the very basics of processes, dealing with the state.

How can a process be used to keep a state?

The game is to proceed incrementally. I already had two tests, one to document how to start a process, and a second to document how to send and receive messages between processes.

Now I wanted to add new documentation, without breaking the first two tests.

Let's try to add a little feature and allow our process to support multi-language:

```elixir
test "returns 'Hola mundo!' when receive :greet and starts with :es" do
  pid = spawn(MyProcess, :loop, [:es])

  send(pid, {self(), :greet})

  assert_receive "Hola mundo!"
end
```

Everything started with a **red bar**. There were a few things I had to learn before being able to have a **green bar**:

- How to keep the state?
- How to provide a different answer based on a specific state?

```elixir
defmodule MyProcess do
  def loop(language \\ :en) do
    receive do
      {from, :greet} ->
        message =
          case language do
            :es -> "Hola mundo!"
            _ -> "Hello world!"
          end

        send(from, message)
        loop(language)

      _ ->
        loop(language)
    end
  end
end
```

Above you can see how the `loop` function had to change to support this new feature. Besides learning how to keep and use the state internally, I also learned - as a bonus point - how to define default values for function arguments (`loop(language \\ :en)`).

## Green bar, refactor and design

Having reached that point helped me to gain more confidence with a few of the key concepts of the language, and as result, I have a living artifact I can use to continue learning and experimenting on.

As I generally do, once in a **green bar** - thus, having all the tests passing - I prefer to stop for a moment, look a the overall code, and consider a few small changes to improve the design.

Looking at the following test, and how we interact with the process we have designed, it seems that the caller, the test itself, have to know too many details:

```elixir
test "returns 'Hola mundo!' when receive :greet and starts with :es" do
  pid = spawn(MyProcess, :loop, [:es])

  send(pid, {self(), :greet})

  assert_receive "Hola mundo!"
end
```

The caller have to know about:

- The loop function and its argument (`spawn(MyProcess, :loop, [:es])`)
- The format of the message (`send(pid, {self(), :greet})`)
- It should wait for a message to be sent back to it (`assert_receive "Hola mundo!"`)

### Addressing the loop function and its argument

When **starting the process**, the caller needs to know about:

- The name of the loop function
- The argument to pass to the function

I would rather prefer the caller to know just what is needed to start the process, so **extract and move the method** to `MyProcess` so that this intent will be well encapsulated, and the details hidden from the caller [^1]:

```elixir
defmodule MyProcess do
  def start(language \\ :en) do
    spawn(MyProcess, :loop, [language])
  end

  ...
end
```


```elixir
test "returns 'Hola mundo!' when receive :greet and starts with :es" do
  pid = MyProcess.start(:es)

  send(pid, {self(), :greet})

  assert_receive "Hola mundo!"
end
```

Run the test, and we are still green!

### Addressing the format of the message

As we did for the `start()` function, I would hide the details about the exact format of the message to send (`send(pid, {self(), :greet})`) and express the intent of "greeting" through a better interface. Same steps as before, **extract and move method**:

```elixir
defmodule MyProcess do
  ...

  def greet(pid) do
    send(pid, {self(), :greet})
  end

  ...
end
```

```elixir
test "returns 'Hola mundo!' when receive :greet and starts with :es" do
  pid = MyProcess.start(:es)

  MyProcess.greet(pid)

  assert_receive "Hola mundo!"
end
```

Again, re-run the tests, and we are still green!

### Waiting for a response ...

The last point I wanted to address is more a concern of *usability* and about how the interaction between the caller (the test) and the callee (`MyProcess`).

The current implementation is telling that is the responsibility of the caller to wait and handle a response (`assert_receive "Hola mundo!"`), furthermore, the call is asynchronous (since `send` is not blocking).

Nothing is wrong with an implementation like this. Everything now is more subjective, and specific to the caller's requirements. Should the caller have to wait and check for the correct response? Should the caller send the messages asynchronously? Probably yes, probably not. What should happen if an unexpected message is received?

I am going to use this as an extra example to reflect on design/usability concerns in code.

Let's say we wanted to provide a synchronous experience to the caller, and having something like this:

```elixir
test "returns 'Hola mundo!' when receive :greet and starts with :es" do
  pid = MyProcess.start(:es)

  response = MyProcess.greet(pid)

  assert response == "Hola mundo!"
end
```

In this case, the `greet` function is blocking and synchronous, this means that all the logic for waiting for a response and manage any unexpected messages become a detail of the function itself:

```elixir
defmodule MyProcess do
  ...

  def greet(pid) do
    send(pid, {self(), :greet})
    receive do
      response -> response
    end
  end

  ...
end
```

To my great surprise, I also learned that is *idiomatic* of Elixir to have a *client* and *server* -side, as part of the module definition. It's common to see these two parts grouped and separated by comments, where the client functions happen to be defined in the above part of the module, while the server functions in the bottom.

## Conclusion

*"Testing the documentation"*, the practice of incrementally build a living artifact of the the programming language documentation, can be of great support during the learning process, since we can use tests for:

- Frame each learning session on a specific concept of the language.
- Keep the focus only on one thing at a time.
- Refactor. Iterate over the living artifact to refine our learnings.
- Set a good pace.

If you are curious, there you can find [my living documentation of Elixir](https://github.com/joebew42/elixir-playground).

[^1]: [Encapsulation Is Not Information Hiding](http://wiki.c2.com/?EncapsulationIsNotInformationHiding)