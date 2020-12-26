---
layout:   post
title:    "Software Architecture is \"overrated\""
date:     2020-12-23 10:00:00 +0100
tag:      programming
summary:  "Software Architecture is an important topic, but it's overrated, or we are approaching it the wrong way."
---

> Software Architecture is an important topic, but it's overrated, or we are approaching it the wrong way.

A few days ago I had a conversation with some friends about software architecture, and although this is an important area of the software industry, in my opinion it is overrated [^1], or we are probably approaching it the wrong way.

I believe Software Architecture should not have as much space, as long as the role of Software Architect should not exist.

I will tell you why.

**Software architecture** is the field responsible for all those high-level decisions or qualities that ensure the effective functioning of a software system. These are all qualities that change according to the system we are building.

We most commonly refer to these qualities using terms such as intrinsic properties or **non-functional requirements**.

A few examples of non-functional requirements are:

- Scalability
- Performance
- Interoperability
- Reliability
- Availability
- Security
- Deployability

Even if all these qualities are not strictly connected with the **functional requirements**, they are still critical for the correct delivery of them. If our business is about payments processing and the system architecture is poor of reliability and availability, we may be in troubles.

The person responsible for the overall system architecture, who primarily focuses on making all those high-level decisions, is the Software Architect.

**The undesirable effect** of working with this approach, or rather of centralizing the responsibility of the overall architecture on an individual, **is to fall into the trap of diverging from the business needs**, because too focused on the resolution of the single technical task, instead of what's really needed for the business goal.

What I propose is that contrary to this approach, **the team**, owner of the project or product, **should have the right to make architectural choices**. In the same way that the team implements a new feature, they should also be aware of the necessary high-level requirements in terms of security, availability, performance, and so on, which could affect functionality.

**We should start approach "non-functional requirements" as business requirements**, expecting to find them all while discussing User Stories or features with stakeholders or the product owner, **and not as a separate activity**.

Then **delegate the responsibility of finding the best architectural choice to the team**, and not to a Software Architect.

## Architecture change as business does ...

... And the code changes too.

Said that, keep in mind about the reality of the adoption and life-cycle of the system. [^2] Do not over-engineer.

**Software architecture decisions should always be driven by business requirements.** We are not going to implement a faster delivery process if the change rate is low, or the time to market is not much important. Like, we are not going to implement a quick and automatic scaling solution if there are no numbers to justify it.

We should **move away from the big up-front design approach**, or the desire to provide future-proof architecture, **in favor of an emergent approach**.

Eventually, business requirements can and will change.

If scaling or faster delivery process wasn't an issue before, they will be as soon as they have a real impact on product quality and business.

The architecture of a system should move along with business goals.

## Software Architectures are Design Patterns at a higher-level

I see Software Architectures on the same line as Design Patterns for computer programming. Design patterns are good and we should use them when we see a real benefit in doing so. The same is true for software architectures.

It is always good to stay up to date on the latest software architectures and understand what kind of problems they are solving, but I will not spend more time on this topic.

I have used the term **"Software Architectures"**, note the plural, because they represent a catalog of reusable solutions to recurring higher-level software problems.

## Keep application decoupled from architectural changes

The suggestion I always feel to give is trying to **to keep the application code as decoupled from external details as possible** and avoid the trap of building a system that relies solely on some external details, such as database engines, communication protocols, or cloud providers, or high-level decisions.

A great starting point for learning the techniques for making an application independent of external details is [**The Twelve-Factor App**](https://12factor.net/).

## Architect is an act, not a role

It is the team's effort to explore and converge towards higher-level system design decisions that are good enough for current business needs, and accommodate changes in business requirements while keeping the impact on the application low. To architect, should be a collaborative and shared act across the team and not a role to be assigned to a single individual.

**If you are a Software Architect** and the team is not mature enough to talk about architectural issues, **you can support and help them by facilitating architectural discussions**, with the business goals and requirements always in mind!

[^1]: [Software Architecture is Overrated, Clear and Simple Design is Underrated](https://blog.pragmaticengineer.com/software-architecture-is-overrated/).
[^2]: Thanks _druhlemann_ for the feedback given on the [reddit discussion](https://www.reddit.com/r/programming/comments/kizie4/software_architecture_is_overrated_questions_and/).