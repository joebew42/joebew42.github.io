---
layout: post
title:  "Dependency Injection with Elixir"
date:   2020-05-16 10:00:00 +0100
excerpt_separator: <!--more-->
---

> Some of my experiences in dealing with Dependency Injection with Elixir

<!--more-->

In computer programming, the **dependency injection** is the technique to pass objects (or functions) to another object (or function). If you came from functional programming, I guess then the term **composition** will be more familiar to you.

There are several good reasons for using this technique, and it leads to important advantages in the overall code design, which I am not going to discuss here. The technique itself and its relation with software design deserve to be discussed in a separate post from this one.

Since the purpose of this post is not to talk about the technique itself, I want to share some of my experiences in trying to apply it with Elixir.

## A quick example of dependency injection

I will take some inspirations from the [birthday greetings kata](https://github.com/xpmatteo/birthday-greetings-kata), where you have to send a birthday greeting message to all the employees who have the birthday on the current day.

Suppose we'll write something like this:

```elixir
def send_greetings() do
  Employees.all()
  |> Enum.filter(fn employee -> birthday_today?(employee) end)
  |> Enum.map(fn employee -> GreetingMessage.create(employee) end)
  |> Enum.each(fn message -> GreetingMessageSender.send(message) end)
end
```
We could identify three different collaborators there:

- The `Employees`, to returns all the employees.
- The `GreetingMessage`, to create the greeting message.
- And the `GreetingMessageSender`, to send the greeting message.

The reasons why we might have to choose different implementations of each collaborator may be different: testing purposes, we might want to change the source from which we access the employees (from a database, from an external service, or from an in-memory storage). Or we might want to change the way we create the greeting message. Or having different mechanism to send the message (email, social media, or whatever).

## Injection through Application.get_env()

...

## Topics

- Inject via application configuration and its implication
- Inject at runtime
- Inject using a global object (`Config`)
- Inject using function arguments
- Using Mocks?
