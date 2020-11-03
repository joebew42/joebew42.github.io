---
layout:   post
title:    "Essence and Learning in Code"
date:     2020-11-03 10:00:00 +0100
tag:      programming
summary:  "In the last few months, I have explored new ways to keep the process of writing code a little bit more disciplined. Here I want to share this experience, and what I think I have learned."
---

> In the last few months, I have explored new ways to keep the process of writing code a little bit more disciplined. Here I want to share this experience, and what I think I have learned.

<!--more-->

It has been a while since I started to try the [Slicing Functionality: Alternate paths](https://xp123.com/articles/slicing-functionality-alternate-paths/) strategy while doing TDD on a few Code Katas.

In his article, [William Wake](https://twitter.com/wwake) describes a strategy that might be handy when it comes to understanding _how to split a project into several parts_ (e.g. user stories), instead of tackling it as a whole.

## How to split a project?

The decision is based on:

- What slice represents the essence of the project?
- What slice can help me to learn the most?

## A slicing example

I will take one of the example proposed by William Wake, just to give you a practical idea of how this strategy can be translated into the real world, but I want to encourage you to read the original article.

Consider you have to build **a web-based e-commerce system**.

There are several things that we might have to deal with to have a full, working, and web-based e-commerce system.

So, let's split it into several parts then.

If we try to find **the slice that represents the essence of the system** we could all agree that at its bare minimum, this system can be expressed as a simple **purchase transaction**.

On the other hand, finding **the slice that can help us learn the most** is more a matter to be aware of the places where we feel we are more at risk, and moving away from the analysis paralysis limbo.

What framework to use? Should we have to use a framework at all? How to handle security certificates? Which payment gateways to use? How to use them? Where to store the logs? Which platform to use to collect metrics? What database? How to integrate the product catalog with existing external solutions?

And we can continue with all other parts of the system where we feel more at risk and therefore, address them as quickly as possible to learn and regain our comfort zone.

The **prioritization between the essence and learning slices** it then depends on which slice gives us the most in terms of **value** in a given time.

## Applying this strategy while at code

I have found this article so inspirational, and I decided to practice this strategy while doing TDD on a few code katas [^1]:

- [Poker Hands Kata](https://codingdojo.org/kata/PokerHands/)
- [Gossiping Bus Drivers Kata](https://kata-log.rocks/gossiping-bus-drivers-kata)
- [Mars Rover Kata](https://kata-log.rocks/mars-rover-kata)
- [Unusual Spending Kata](https://kata-log.rocks/unusual-spending-kata)

I wanted to understand how does it feel when a strategy like this is applied while writing code, what are the outcomes and that's why I am writing this blog; To summarize and share my experience with you.

### Poker Hands Kata

This was the very first Code Kata where I tried to adopt the slicing strategy. We are asked to read two poker hands formatted as a string, and then reveal the winning player and its point:

Input example:

```
Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH
```

Output example:

```
White wins. - with high card: Ace
```

In my **first attempt** I was working alone, and after some reasonings, I thought that the **slice that better describes the essence of the game** could be to _extract the Rank from a set of five Cards_.

So, I started to write the code that was able to extract the rank from a set of five cards, and I tried to start from the _simplest_ case there: given a set of five cards I wanted to extract the card with the higher value.

In the **second attempt**, I was not alone anymore, and I had the opportunity to pair up with [Piero Di Bello](https://twitter.com/pierodibello/).

Here I want to remark once again that **pair programming** or **mob programming** are really effective practices when it comes to having a better feedback loop on what to prioritize first, **the essence**, or **the learning** part. And of course, provide a better view of what the real essence of the system really is, since you have different perspectives.

And that's exactly what happened while pairing with Piero. We redefined **the essence** of the poker hands, starting very small.

In this new attempt, the essence of the game was just that _a Card with a higher value wins against another Card_.

I would not say that the first attempt was better than the second, or vice versa.

As a final consideration I would say that in the second attempt, the approach was more incremental since we started with a reduced world of poker where the two players had just one card each. And then we proceeded by adding a second card, and then a third, and so on.

### Gossiping Bus Drivers Kata

In this code kata, we are asked to determine the number of stops needed until all the bus drivers have exchanged all their gossips. It's a tricky code kata if you try to tackle it from the algorithmic point of view, but I would say that everything came much easier when we start from a small approach, as it happened to me when I started to think at its real essence.

If had to think about the **essence** of this system I would say that _a bus driver is able to exchange its gossip with another driver_. That's it. Nothing more, nothing less.

And that was the point where I started to write my code. And I would say that ending up with a working solution was easier than expected!

### Mars Rover Kata

This code kata became quite popular thanks to [Sandro Mancuso](https://twitter.com/sandromancuso) and his demonstration on [Outside-In Classicist TDD](https://www.youtube.com/watch?v=24vzFAvOzo0). I would invite you to go and check out that video if you are interested in Outside-In TDD with a Classicist approach.

Here we are asked to program a Rover so that it will be able to move accordingly to an array of commands while being aware of the surrounding obstacles, and some other constraints of the world.

Regardless of the requested requirements, I tried to reduce them at their bare minimum, and thus to find the "real" essence of the system, I came out with a simple requirement: _a rover is able to move up_.

I removed all the concepts like commands, obstacles, direction, and so on.

At its bare minimum, I want a rover to be able to move up. Nothing more, nothing less.

Starting from there, I then continued followed an incremental approach by supporting the concept of a single command, a sequence of commands, the obstacles, and so on.

### Unusual Spending Kata

_I am currently working on it_ :nerd_face: Wait for it!

## Conclusion and takeaways

I feel my development experience has been enriched since I have started to use this new line of thought while writing code. Being able to choose between **the part of the code that best capture the essence of what I have to implement**, and **the part of the code where I believe I am more at risk and I have the opportunity to learn the most if I try to address it sooner**, gives me a better sense of what to address first, based on the value of doing it.

Here will follow a few things I have noticed while applying this practice:

- The **"essence" part** was always reflecting the domain logic. I used it as my first driving force.
- The **"learning" part** was always something related to: refactorings opportunities, exploratory code, parsing and formatting, delivery mechanisms, and so on, everything that it's needed but not strictly related to the domain of the application.
- Switch between essence and learning parts was happening quite often. It was important to keep a note about all the pieces of the code left behind while switching context. I ended up using the TODO list[^2], comments in the code, throwing exceptions for the not finished of unhandled cases in the code, and so on.
- Common sense and experience are important factors. Sometimes trying to defer important design decisions at the most end part might be useful. Are we gonna learn something doing this refactoring? If the answer is NO, best defer the decision (e.g. premature refactorings, or premature optimizations).
- Pair or Mob Programming are very effective practices since discussions are crucial to identifies the essences, the learning points and agree on what to prioritize first.

[^1]: Solutions to Code Katas: [Poker Hands Kata (in Elixir)](https://github.com/joebew42/poker_hands_elixir), [Poker Hands Kata (in Java)](https://github.com/xpepper/poker-hands-kata), [Gossing Bus Drivers Kata (in Java)](https://github.com/joebew42/gossiping-bus-drivers-kata), [Mars Rover Kata (in Java)](https://github.com/joebew42/mars-rover-kata), and [Unusual Spending Kata (in Java)](TODO).
[^2]: [TODO List: One thing at a time!]({% post_url 2020-07-08-todo %})
