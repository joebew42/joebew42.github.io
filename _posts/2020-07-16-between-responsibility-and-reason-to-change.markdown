---
layout:   post
title:    "Between Responsibility and Reason to change"
date:     2020-07-16 10:00:00 +0100
tag:      programming
summary:  "A case study on the Single Responsibility Principle: Reasons to Change, Responsibility, Testability and Trade-offs in Code."
---

> A case study on the Single Responsibility Principle: Reasons to Change, Responsibility, Testability and Trade-offs in Code.

<!--more-->

## A Parser for a Poker Hand

For the last few months, I've been pair programming with some of my friends, [Piero Di Bello](https://twitter.com/pierodibello) and [Matteo Pierro](https://twitter.com/matteo_pierro). We were practicing TDD on the [Poker Hands Kata](https://github.com/xpepper/poker-hands-kata/tree/b1295dd54e5f6a6a27ad5f7491df890bf855cd8a).

As part of the requirements of the Code Kata is asked to parse the players and their hands from an input string, formed as follow:

```
Black: 2H 3D 5S 9C KD White: 2C 3H 4S 8C AH
```

After some sessions of coding we ended up writing a parser built on few classes:

```Java
public class PlayerParser {
    private final HandParser handParser = new HandParser();

    Player parse(String rawPlayer) {
        String name = rawPlayer.split(":")[0];
        String rawPokerHand = rawPlayer.split(": ")[1];
        Hand hand = handParser.parse(rawPokerHand);
        return new Player(name, hand);
    }
}
```

_That has the responsibility to parse the Player: `Black: 2H 3D 5S 9C KD`_

```Java
public class HandParser {
    private final CardParser cardParser = new CardParser();

    Hand parse(String rawPokerHand) {
        String[] rawCards = rawPokerHand.split(" ");
        Card firstCard = cardParser.parse(rawCards[0]);
        Card secondCard = cardParser.parse(rawCards[1]);
        return new Hand(firstCard, secondCard);
    }
}
```

_That has the responsibility to parse the Hand: `2H 3D 5S 9C KD`_

```Java
public class CardParser {
    ...

    Card parse(String rawCard) {
        Character rawCardValue = rawCard.charAt(0);
        Card.Value value = CHAR_TO_VALUE.get(rawCardValue);

        Character rawCardSuit = rawCard.charAt(1);
        Card.Suit suit = CHAR_TO_SUIT.get(rawCardSuit);

        return new Card(value, suit);
    }
}
```

_That has the responsibility to parse the Card: `2H`_

We had a really **pleasing discussion** around the decision of having three different classes, one for each part of the string (a class to parse a single `Card`, a class to parse the `Hand`, and lately, a class to parse the `Player`) instead of having a single class for the parser.

## Why don't have the Parser in a single class?

That was the question that laid the foundations for the pleasing discussion.

Thank you Matteo for raising this question. This is also the reason why I decided to write this blog. We discussed some good points that deserves to be shared with the community.

So, back to the question: **Why don't put the Parser in a single Class?**

Short answer, yes! We can have the parser entirely defined in a single class.

Are we not violating the _Single Responsibility Principle_[^srp] ?

Shouldn't the classes be small and have only one reason to change?

Let's first think about the **responsibility** and the **reason to change** of a parser like that. I will discuss the Single Responsibility Principle later in this blog.

We can assume that the **responsibility of this parser** is to satisfy the requirements of the client that will make use of the poker game, through specific requests. The client will send requests to play a poker game using a string formatted like that. No more, no less.

The **only reason to change** is a different format for the input string. If the format of the string changes, we need then to open the class and modify it.

If nothing is gonna change, having the parser with a single class is a well and reasonable decision. No other string formats to support, no other kind of input, just straight with that input.

## The Parser in a single class

```
PlayerParser

+ Player parse(String)

- Hand parseHand(String)
- Card parseCard(String)
```

The parsing of the `Hand` and its `Card`s are now an implementation detail of the method `parse`, and they are now `private`. There is no need for a _client_ to have direct access to these methods since the _client_ or the _caller_ will always use the public interface which exposes the method `parse(...)`.

```Java
public class PlayerParser {

    Player parse(String rawPlayer) {
        String name = rawPlayer.split(":")[0];
        String rawPokerHand = rawPlayer.split(": ")[1];
        Hand hand = parseHand(rawPokerHand);
        return new Player(name, hand);
    }

    private Hand parseHand(String rawPokerHand) {
        String[] rawCards = rawPokerHand.split(" ");
        Card firstCard = parseCard(rawCards[0]);
        Card secondCard = parseCard(rawCards[1]);
        return new Hand(firstCard, secondCard);
    }

    private Card parseCard(String rawCard) {
        Character rawCardValue = rawCard.charAt(0);
        Card.Value value = CHAR_TO_VALUE.get(rawCardValue);

        Character rawCardSuit = rawCard.charAt(1);
        Card.Suit suit = CHAR_TO_SUIT.get(rawCardSuit);

        return new Card(value, suit);
    }
}
```

As I said, having the parser in a single class is also a good way to go. The class it's not even big. It is also "easy" to grasp, read and identify what each method does.

## The Single Responsibility Principle

The _Single Responsibility Principle_ [^srp] is quite popular, probably one of the most important principles in Software Design. Introduced in the late 1990s, by Uncle Bob, the principle states the following:

> _"A CLASS SHOULD HAVE ONLY ONE REASON TO CHANGE."_

Find one _reason to change_ and take everything else out of the class, so that you’re granted to separate those responsibilities in new classes, or modules.

But then, **the question**.

## What defines a reason to change?

The following is the famous code snippet that Uncle Bob uses to explain the concept of _reason to change_.

```Java
public class Employee {
  public Money calculatePay();
  public void save();
  public String reportHours();
}
```

And the answer is People.

The answer to the question "What defines a reason to change?" is **People**.

Reason why code changes is because people ask for changes, based on their needs. And usually their needs are dependant on the area of the business they are responsible for.

Said that, following the example of the `Employee` class, we can stop for a moment and reflect on each of the methods we have there:

```Java
public Money calculatePay();
```

Is a concern for the people responsible to manage the **payroll**.

```Java
public void save();
```

Is a concern for the people responsible to deal with the **data**.

```Java
public String reportHours();
```

Is a concern for the people responsible to **check and audit the report of the worked hours** of an employee.

## Isolate the reason to change

We also tend to avoid coupling the way we store data, from its views.

It is a common pattern that we have seen and used to work with several frameworks, Rails, Django, Spring, and other popular ones.

Each reason to change represent a different concern a person, or a group of people have in a particular area of their business:

- UI
- Payroll
- Data
- Reporting

Each of these areas will eventually grow and change with different reasons and rhythm from the others:

- The Payroll area could change the procedure to calculate the payroll for a particular year, or for a particular employee. Or implement more complex rules.
- The Data area could improve the way the data is stored, indexed, processed, or decide to opt-in with a new storage mechanism.
- The Reporting area could change the way the report is built, change the layout of the report, add some more information, or extend it with a new format.

And we prefer not to mix things that are not related together, with the chance to introduce defects in one specific area because of the changes introduced into another.

e.g. We do not want to break the Payroll procedure because we changed the way the Data is stored.

> _"Gather together the things that change for the same reasons. Separate those things that change for different reasons."_ - Uncle Bob

## Separation of concerns in the Employee class

Looking at the `Employee` class, we can separate those concerns in isolated class, and I will propose a new hypothetical arrangement of the code:

```Java
public class Payroll {
  public Money calculate(Employee employee);
}
```

So that when a change to the payroll happens we know it will affect the `Payroll` class only.

```Java
public class Repository {
  public void save(Employee employee);
}
```

So that when a change to the data happens we know it will affect the `Repository` class only.

```Java
public class AuditReport {
  public String generate(Employee employee);
}
```

So that when a change to the report happens we know it will affect the `AuditReport` class only.

And so on.

## NOT only people. Maintainability also!

**Maintainability** is also one of the great benefits when isolating the reason to change from each other. Having extracted the three different concerns from the `Employee` into three different classes:

- `Payroll`
- `Repository`
- `AuditReport`

Gives us better control from the **testability** point of view.

Thinking at the test suite of an employee class which has different reasons to change we can easily guess that its test suite will be organized at least into three different sections, one for each area:

```Java

public class EmployeeTest {

  @Test
  public void payroll_include_a_ten_percent_tax_less_when_junior() {
    ...
  }

  @Test
  public void payroll_include_a_twenty_percent_tax_less_when_senior() {
    ...
  }

  // Another section for the Data
  // ...

  // Another section for the AuditReport
  // ...

}

```

With the result to have a reasonably big test suite for the `Employee`, and dealing with big test suite or big classes, or modules, are often two sides of the same coin:

> Classes or modules that centralizes too many responsibilities tend to be difficult to read and maintain.

## So, how many classes for the Parser?

I don't think there is a right or wrong design decision here.

Both the solutions are valid. One class, or three classes, are certainly good ways to go. In both cases, the Single Responsibility Principle still hold, since as we have seen, the principle is more about people than code.

In the end, we preferred the version of the parser that uses three classes.

This is also my personal preference, backed by some reasons I want to share with you:

### 1. Symmetry

I like to see that the parser is well mapped with the components of our domain, in a way that a `Player`, an `Hand` and a `Card`, have their own parsers. Respectively, the `PlayerParser`, the `HandParser`, and the `CardParser`.

Domain and Parser are kept in symmetry.

### 2. Testability

It's easy to test the behavior of the parsing of an hand, or a single card, in isolation. Using the single class version of the parser, we might feel tempted to access the private methods (e.g. `parseHand`, or `parseCard`) due to _Insufficient Access_ [^synergy_between_testability_and_design] on the parser class.

### 3. Comprehensibility

I don't have to puzzle my mind scanning through a lot of lines of code looking for the part of the code I am interested in.

Less cognitive load.

[^srp]: Robert C. Martin, [The Single Responsibility Principle](https://blog.cleancoder.com/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html)
[^synergy_between_testability_and_design]: Michael Feathers, [The deep synergy between testability and good design](https://www.youtube.com/watch?v=4cVZvoFGJTU)
