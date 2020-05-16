---
layout: post
title:  "Dependency Injection with Elixir"
date:   2022-05-16 10:00:00 +0100
excerpt_separator: <!--more-->
---

> Some of my experiences in dealing with Dependency Injection with Elixir

<!--more-->

In computer programming, the **dependency injection** is the technique to pass objects (or functions) to another object (or function). If you came from functional programming, I guess then the term **composition** will be more familiar to you.

There are several good reasons for using this technique, and it leads to important advantages in the overall code design, which I am not going to discuss here. The technique itself and its relation with software design deserve to be discussed in a separate post from this once.

Since the purpose of this post is not to talk about the technique itself, I want to share some of my experiences in trying to apply it with Elixir.

## An example of dependency injection

As an example suppose you have a function that performs some logic and then submit the result, either via standard output, or log facilities, or sending the result through a third-party API.

## Topics

- Inject via application configuration and its implication
- Inject at runtime
- Inject using a global object (`Config`)
- Inject using function arguments
- Using Mocks?
