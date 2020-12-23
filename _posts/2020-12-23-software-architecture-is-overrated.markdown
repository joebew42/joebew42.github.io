---
layout:   post
title:    "Software Architecture is overrated"
date:     2020-12-23 10:00:00 +0100
tag:      programming
summary:  "Software Architecture is an important topic, but it's overrated."
---

> Software Architecture is an important topic, but it's overrated.

A few days ago I had a conversation with some friends of mine about software architecture and to be honest, I'm not a huge fan of this area.

In general, this is an overrated topic of the software industry. It shouldn't have as much space, as long as the role of Software Architects shouldn't exist.

I will tell you why.

**Software architecture** is the study and application of all those high-level decisions or qualities that guarantee the correctness of the execution of a system once it has been deployed in production. These qualities can change according to the system we are building.

We often refer to these qualities using terms like intrinsic properties, or **non-functional requirements**.

A few examples of non-functional requirements are:

- Scalability
- Performance
- Interoperability
- Reliability
- Availability
- Security
- Deployability

These are all requirements that should come with the business.

In the same way that we implement a new feature in the system, we should also be aware of the necessary high-level requirements in terms of security, availability, performance, and so on.

Since I like to treat all these "non-functional requirements" as **business requirements**, I expect to find them all while discussing User Story or functionality with stakeholders or the product owner.

Then delegate the responsibility of finding the best choice of architecture to the team itself and not to a Software Architect.

## Architecture change as business does ...

... And the code changes too.

The primary drivers for a "software architecture" should always be business requirements. I am not going to implement a faster delivery process if the change rate is low and time to market is not much important.

But business requirements can and will change.

If scaling or faster delivery process wasn't an issue before, they will be as soon as they have a real impact on product quality and business.

The architecture of a system is only the result of current business needs.

## Software Architectures are Design Patterns at a higher-level

I see software architectures on the same line as Design Patterns for computer programming. Design patterns are good and we should use them when we see a real benefit in doing so. The same is true for software architectures.

It is always good to stay up to date on the latest software architecture and understand what kind of problems they are solving, but I will not spend more time on this topic.

I have used the term **"Software Architectures"** - note the plural - because it is a catalog of reusable solutions to recurring higher-level software problems.

## Conclusion

I would rather invest more time trying to keep my application code as decoupled from external details as possible.

[The Twelve-Factor App](https://12factor.net/) is a good place to start.

We should be moving in a direction where architectural changes may not have an impact on our application.
