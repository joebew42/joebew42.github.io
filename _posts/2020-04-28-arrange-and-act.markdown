---
layout: post
title: "The three forces of Arrange, Act and Assert"
date: 2020-04-24 15:00:00 +0100
tag: programming
summary: "Arrange, Act and Assert (AAA) represent the overall anatomy of a test. Sometimes they're like forces moving in different directions. I am going to share a way to identify when this happen and a strategy to have them aligned towards same direction."
---

> Arrange, Act and Assert (AAA) represent the overall anatomy of a test. Sometimes they're like forces moving in different directions. I am going to share a way to identify when this happen and a strategy to have them aligned towards same direction.

<!--more-->

During the past few months, [Piero Di Bello](https://twitter.com/pierodibello/) and I have been doing pair programming in a weekly basis, doing [Code Katas](<https://en.wikipedia.org/wiki/Kata_(programming)>), sharing our resulting [code](https://github.com/xpepper?tab=repositories), the stories and the learnings with the community, as already happened here: [One assertion per test?](https://medium.com/@pierodibello/one-assertion-per-test-732cc2a7d3d).

In this post I want to share one of the key learning I had during one of these programming sessions, where we were working on the [Game of Life Kata](http://codingdojo.org/kata/GameOfLife/) (the code can be found [here](https://github.com/xpepper/game-of-life-kata)).

As part of this journey we took some stops to reflect and compare our design decisions with the ones presented in the [Understanding the Four Rules of Simple Design](https://leanpub.com/4rulesofsimpledesign) book. In his book, [Corey Haines](https://twitter.com/coreyhaines) is using the same Code Kata to illustrate the rules of simple design.

> The [Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) is a simulation which involves several cells to interact each other following few simple rules. Each next iteration is then obtained by applying these rules on each cell.

Curious to see the Game of Life in action? Here is a glimpse!

<p><a href="https://commons.wikimedia.org/wiki/File:Gospers_glider_gun.gif#/media/File:Gospers_glider_gun.gif"><img src="https://upload.wikimedia.org/wikipedia/commons/e/e5/Gospers_glider_gun.gif" alt="Gospers glider gun.gif"></a><br>By <a href="//commons.wikimedia.org/wiki/User:LucasVB" title="User:LucasVB">Lucas Vieira</a> - <span class="int-own-work" lang="en">Own work</span>, <a href="http://creativecommons.org/licenses/by-sa/3.0/" title="Creative Commons Attribution-Share Alike 3.0">CC BY-SA 3.0</a>, <a href="https://commons.wikimedia.org/w/index.php?curid=101736">Link</a></p>

## The evolution of the world

As our development process continued - following an inside-out approach, from the logic of a single `Cell` - we had to face the _evolution_ of a group of cells: generating a new group of `Cell`s starting from a current one.

In our emerging design we used the noun `World` to represent the concept of a group of cells, and the predicate `.evolve()` to generate the next iteration of the world. You can see it as something like as follow:

```java
class World {
  public World evolve() {
    ...
  }
}
```

We proceeded to write a test first and we ended up with:

```java
public static final World AN_EMPTY_WORLD = new World();

@Test
public void a_world_with_a_single_alive_cell_will_evolve_to_an_empty_world() {
  World world = new World();
  world.addCell(Cell.live(), 1, 1);

  World nextWorld = world.evolve();

  assertEquals(AN_EMPTY_WORLD, nextWorld);
}
```

Before moving to the next paragraph, I want you try to stop a moment at this test and think about how many things are happening there.

## The "Forces, Axes or Dimensions" Metaphor

As we reached the point to write down that test, Piero helped me notice that tackling the "evolution" starting from this point would have been a step too big.

He used this - powerful - metaphor of _"Forces, Axes or Dimensions"_ in a sense that if we look at our test we can recognize at least **two forces that are moving along different axes (or dimensions)**:

**First force: The construction of a world:**

```java
World world = new World();
world.addCell(Cell.live(), 1, 1);

assertEquals(AN_EMPTY_WORLD, nextWorld);
```

**Second force: The evolution of a world:**

```java
World nextWorld = world.evolve();
```

As an important detail to mention, the _evolution of a world_ strictly relies on the _construction of the world_. In other words, **it's not possible to verify the correctness of the evolution of a world if not being able to compare the state of two worlds.**

![Forces of Arrange, Act and Assert](/assets/forces-of-arrange-act-assert.png)
_An attempt to visualize the "forces" in action._

With that in mind we reviewed our schedule, trying to solve the **construction of a world** first, and tackle the **evolution of the world** only after. Proceeding with single small steps at a time.

Our new TODO list was more or less like this:

- A new world is an empty world (no need to work on `addCell`).
- A world with a cell is not an empty world (provide the `addCell`).
- Two worlds with the same cells are equals.
- Two worlds with cells located in different positions are not equals (provide a `Location` to each cell).
- Evolution of a world with few cells (using a simple pattern of the Game of Life).

Proceeding this way may result now more linear and incremental, allowing us to win a shortest feedback loop of the development.

> Try to identify the "forces" in action in your tests. Look at your arrange, act, and assert parts. Are they moving long the same axes or dimensions? If not, try to tackle them one at time. Starting from the one on which the others depend.

## Learnings

The thing I think I have learned from this experience is that from this moment on I will try to be more careful about the _real_ part of the system we want to test, at the possible _forces_ in play, and at the smallest possible steps to follow to gradually implement everything needed.

Perhaps asking myself few more questions, like:

- Does the logic under test depend on two or more methods/functions that have - still - to be implemented?
- What is the method or function on which the others depend?
- What are the smallest possible steps to implement all of these methods incrementally?
- How can I keep the development feedback loop as shortest as possible?
