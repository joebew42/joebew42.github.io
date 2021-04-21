---
layout:   post
title:    "Software Architecture is \"overrated\". Revisited."
date:     2021-03-17 9:00:00 +0100
tag:      programming
summary:  "Software Architecture is more about cost of maintenance and development productivity."
---

> Software Architecture is more about cost of maintenance and development productivity.

In a previous blog [Software Architecture is "overrated"]({% post_url 2020-12-23-software-architecture-is-overrated %}) I was highlighting a few of my opinions about how we should approach software architecture:

- Software Architect is NOT a role.
- Software Architect is an activity.
- The non-functional requirements (or a high-level decision) must be treated as the functional requirements.
- Software Architecture is a team responsibility.
- Programmers with more experience and expertise in architectures should help inexperienced teams.

Although I am still strongly convinced about the points expressed above, I want to propose a *revision* regarding the definition of Software Architecture.

## What is Software Architecture?

In the previous blog I wrote:

**Software architecture** is the field responsible for all those high-level decisions or qualities that ensure the effective functioning of a software system. These are all qualities that change according to the system we are building.

We most commonly refer to these qualities using terms such as intrinsic properties or **non-functional requirements** (Scalability, Performance, Interoperability, Reliability, Availability, Security, Deployability).

This is enough, if you are curious you can read the full version of the blog, link above.

## Yes, but it's more about cost and productivity!

Lately, I was reading the book [*Clean Architecture*](https://www.goodreads.com/book/show/18043011-clean-architecture) of [Uncle Bob Martin](https://twitter.com/unclebobmartin), and in his book he provides a more broader definition that touches the *cost of maintenance* and *development productivity*.

> *The primary goal of Software Architecture is to reduce the cost of maintenance by maximizing the development productivity.*

This is achieved by well drawing the boundaries between things that can change for different reasons, such as the user interface, business rules, or storage mechanism.

Separation of concerns.

In his book, he not only emphasizes the **goal** of software architecture: _"Why are we talking about software architecture?"_

He also reminds us that the **non-functional requirements** are details, at the same level of a database, or a delivery mechanism (e.g. the web). While these may be important details, we shouldn't worry much about them.

Among the properties of software architecture (or software design?), we expect decisions on these details can be deferred until the end of development.

This means that _scalability_ shouldn't have any effect on development productivity, as well as decisions like which database to use and how we want to expose our application (web, rest, TCP or whatever ...)
