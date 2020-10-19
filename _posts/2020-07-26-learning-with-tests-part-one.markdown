---
layout:   post
title:    "Learning with Tests: Part I"
date:     2020-07-26 10:00:00 +0100
tag:      programming
summary:  "Tests are a learning catalyst when it comes to learning new programming languages. Here is the part I."
---

> Tests are a learning catalyst when it comes to learning new programming languages. Here is the part I.

<!--more-->

Changes happen, and in our industry, they happen at a very high rate. Tools and programming languages come and go, and during these changes, you too might have to learn new tools or programming languages.

This already happened to me. Several times I found myself in this situation where I had to learn new programming languages, from scratch.

The reasons why we have to start learning new things may vary:

- We have decided to start a new job.
- Our company/client decided to invest in a new programming language.
- Our team decided to try out a new programming language.
- Our favorite programming language is going to be "outdated".
- We just want to learn a new programming language.

In this series, I am gonna show you a practice that I generally use to boost the process of learning a new programming language. And the best of this practice is that it works with whatever programming languages, or even tools.

I am talking about the practice of **using tests as a guiding force of the learning process.**

## Step One

The very first step I do when I am sitting at learning a new programming language is to figure out **how to write the first test**.

And in this process I really need only two things:

- How to easily compile and run my code
- How to Write and run tests

Writing and running tests is what enables me to the learning process.

### Easily compile and run my code

At this stage, my focus is to learn how to compile and run my code. I will go through the official documentation, or ask directly the community.

The question I am eager to answer here is, what is the common way to compile and run the code? Is there any build tool that may automate this process?

Once I get it, then the "Hello World" program is the first milestone.

So far, so good, I think this step doesn't propose anything new from the common process we are often used to follow when learning a new programming language.

Let's take a look at the next step.

### Write and run tests

This is the part that actually proposes the real shift in the learning process.

If we try to see the whole process of learning from the perspective of writing tests, then the very first few lines of code I am willing to compile and run are the ones that describe that my program - or my function - is going to print out the characters sequence "Hello World", when called.

```
include HelloWorld

it_prints_out_hello_world_when_called() {
  assert_is_equal_to "Hello World", HelloWorld.hello()
}

```
_a pseudo-code of a test like that_

From this moment, the goal is to make this test pass.

This translates we have to go through the documentation and understand how to define a function that returns a string type, with the value "Hello World".

No more, no less.

Once we get to the green bar, we are done! :clap:

## How many things did we learn so far?

Even if these two steps may seem very little, we achieved big results.

Let's try to think about at the many things we have learned so far:

- How to easily compile and run code.
- How to run tests: the confidence to see when we introduce regressions, and that our program is behaving as expected.
- We have a sound ground to build our next learnings.

Look at the importance of writing tests:

- Tests are a live documentation of our learning.
- Tests provide a clear direction on what to learn next.
- Tests help us to keep well-defined scope.
- Tests allow us to proceed with baby steps.
- We learn by doing.

**Hint:** Try to use a version control system (e.g. `git`) to save your progress.

## Conclusion

I just wanted to start sharing the technique I am often used to follow when I have to learn a new programming language.

It is my intention to continue to write more about this technique, and show you all the next steps, that eventually will lead us to gain good confidence with a new programming language we were not used to work with.

Hope you liked it!
