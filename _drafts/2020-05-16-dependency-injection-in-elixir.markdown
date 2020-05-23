---
layout: post
title:  "Dependency Injection in Elixir"
date:   2020-05-16 10:00:00 +0100
excerpt_separator: <!--more-->
---

> How to deal with Dependency Injection in Elixir? In this post I am going to share the two ways which I am more comfortable with, and I invite you to share yours!

<!--more-->

In computer programming, the **dependency injection** is the technique to pass objects (or functions) to another object (or another function). If you came from functional programming, I guess terms like _referential transparency_ [^1] or _function composition_ [^2] may be more familiar to you.

There are several good reasons for using this technique, and it leads to important advantages in the overall code design, which I am not going to discuss here. The technique itself and its relation with software design deserve to be discussed in a separate post from this one.

Since the purpose of this post is not to talk about the technique itself, I want to share some of my experiences in trying to apply it with Elixir.

## A quick example of dependency injection

I will take some inspirations from the [birthday greetings kata](https://github.com/xpmatteo/birthday-greetings-kata), where you need to send a birthday message to all employees who are having birthday on the current day.

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

And the reasons why we might have to choose different implementations of each collaborator may be different: testing purposes, we might want to change the source from which we access the employees (from a database, from an external service, or from an in-memory storage). Or we might want to change the way we create the greeting message. Or having different mechanism to send the message (email, social media, or whatever).

That is where the technique of dependency injection may be really helpful.

## Injection through Application.get_env()

Reading the configuration of a Mix application from the [`Application.get_env/3`](https://hexdocs.pm/elixir/Application.html#get_env/3) can be one of the ways that can be used as a mechanism of dependency injection.

The common use case is the ability to switch the application configuration based on a specific environment (e.g. `test`, `dev`, and `prod`). In such a case, our code will look something like that:

```elixir
def send_greetings() do
  employees().all()
  |> Enum.filter(fn employee -> birthday_today?(employee) end)
  |> Enum.map(fn employee -> greeting_message().create(employee) end)
  |> Enum.each(fn message -> greeting_message_sender().send(message) end)
end

defp employees() do
  Application.fetch_env!(:example, :employees)
end

defp greeting_message() do
  Application.fetch_env!(:example, :greeting_message)
end

defp greeting_message_sender() do
  Application.fetch_env!(:example, :greeting_message_sender)
end
```

Some of the compromises I see using this mechanism is to lose the visibility about which collaborator is used in a test, since the actual collaborator is defined in a config file (e.g. `config/test.exs`) and not in the test file itself. A workaround for this could be to change the application configuration as part of the test setup. This might be helpful when we want to use a different implementation of the collaborator in different tests.

## Injection through function parameters

Tackling the _dependency injection_ from a functional programming paradigm means we can pass the collaborators as function parameters.

Here follows a version of the `send_greetings` function where the collaborators are expressed as its parameters:

```elixir
def send_greetings(
      employees \\ Employees,
      greeting_message \\ GreetingMessage,
      greeting_message_sender \\ GreetingMessageSender
    ) do
  employees.all()
  |> Enum.filter(fn employee -> birthday_today?(employee) end)
  |> Enum.map(fn employee -> greeting_message.create(employee) end)
  |> Enum.each(fn message -> greeting_message_sender.send(message) end)
end
```

One of the benefits of this approach is that our code does not depend on a _global_ state (the configuration file) and the dependencies are now explicit.

From testing perspective we will have everything in the same file. No need to touch configurations or moving from the test file to the configuration file to understand what are the collaborators used. We have fewer moving parts in play.

On the downside, it may be a bit harder to quick switch configuration between different environments.

## Conclusions

I am sure there are several other ways out there to achieve dependency injection in Elixir and take the benefits of both approaches:

- As part of the application configuration, to win a quick way to switch environment configuration.
- As function parameters, to win a better visibility, and control of the collaborators.

It's always a matter of trade-offs. Alternative solutions might involve the usage of [Macros](https://elixir-lang.org/getting-started/meta/macros.html), _"home-made"_ implementations, or _"full-fledged"_ frameworks.

I am not here to tell you what the best solution is. Instead, I would rather invite you to try, to experiment, to fail, and eventually find the method that best fits your real needs.

For that reason I have prepared a [dedicated repository on GitHub](https://github.com/joebew42/dependency_injection_in_elixir) that can be used to test different mechanisms of Dependency Injection in Elixir. Feel free to add your solution!

## References

[^1]: [Referential transparency](https://en.wikipedia.org/wiki/Referential_transparency)
[^2]: [Function composition](https://en.wikipedia.org/wiki/Function_composition_(computer_science))
