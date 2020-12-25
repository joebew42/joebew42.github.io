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

**Software architecture** is the study and application of all those high-level decisions or qualities that guarantee the correctness of the execution of a system once it has been deployed in production, and these qualities can change according to the system we are building.

We often refer to these qualities using terms like intrinsic properties, or **non-functional requirements**.

A few examples of non-functional requirements are:

- Scalability
- Performance
- Interoperability
- Reliability
- Availability
- Security
- Deployability

All of these non-functional requirements are often designed by a Software Architect, who is responsible for the overall system architecture.

**The undesirable effect** of working with this approach, or rather of centralizing the responsibility of the architecture on an individual, **is to fall into the trap of diverging from the real goals and business needs**, because too focused on the resolution of the technical task, and far from the real necessity.

Contrary to this approach, **the team**, owner of the project or product, **should be entitled of making architectural choices**.

In the same way that we implement a new feature in the system, we should also be aware of the necessary high-level requirements in terms of security, availability, performance, and so on.

We should approach **"non-functional requirements" as business requirements**, expecting to find them all while discussing User Stories or features with stakeholders or the product owner.

Then **delegate the responsibility of finding the best architectural choice to the team**, and not to a Software Architect.

## Architecture change as business does ...

... And the code changes too.

Said that, keep in mind about the reality of the adoption and lifecycle of the system. [^2]

**Software architecture decisions should always be driven by business requirements.** I am not going to implement a faster delivery process if the change rate is low and time to market is not much important. Like, I am not going to implement a quick and automatic scaling solution if there are no numbers to justify it.

We should **move away from the big up-front design approach**, or the desire to provide future-proof architecture, **in favor of an emergent approach**.

Eventually, business requirements can and will change.

If scaling or faster delivery process wasn't an issue before, they will be as soon as they have a real impact on product quality and business.

The architecture of a system should move along with business goals.

## Software Architectures are Design Patterns at a higher-level

I see Software Architectures on the same line as Design Patterns for computer programming. Design patterns are good and we should use them when we see a real benefit in doing so. The same is true for software architectures.

It is always good to stay up to date on the latest software architecture and understand what kind of problems they are solving, but I will not spend more time on this topic.

I have used the term **"Software Architectures"**, note the plural, because it is a catalog of reusable solutions to recurring higher-level software problems.

## Keep application decoupled from architectural changes

I would rather **invest more time trying to keep my application code as decoupled from external details as possible** and avoid the trap of building a system that relies solely on some external details, such as database engines, communication protocols, or cloud providers.

I can suggest reading [**The Twelve-Factor App**](https://12factor.net/) as a great starting point for exploring methods for making your application independent of external details.

## Architect is an act, not a role

In the end, **architect is an act, not a role**.

It is the team's effort to explore and converge towards higher-level system design decisions that are good enough for current business needs, and accommodate changes in business requirements while keeping the impact on the application low.

**If you are a Software Architect** and the team is not mature enough to talk about architectural issues, **you can support and help them by facilitating architectural discussions**, with the business goals and requirements always in mind!

[^1]: [Software Architecture is Overrated, Clear and Simple Design is Underrated](https://blog.pragmaticengineer.com/software-architecture-is-overrated/).
[^2]: Thanks _druhlemann_ for the feedback given on the [reddit discussion](https://www.reddit.com/r/programming/comments/kizie4/software_architecture_is_overrated_questions_and/).