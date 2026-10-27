---
layout: post
title: "App-First: Fake It Till You Make It"
date: 2026-10-27 9:00:00 +0100
tag: practice
summary: "When a product change goes across the app, the API and the backend, the app is usually the last one in the line. This is how my team turned the company's App-First principle into a practice: we released a good-enough fake API in production, and let backend and app development run in parallel."
---

> When a product change goes across the app, the API and the backend, the app is usually the last one in the line. This is how my team turned the company's App-First principle into a practice: we released a good-enough fake API in production, and let backend and app development run in parallel.

<!--more-->

Have you ever worked on a product change that goes across all the layers: the app, the API and the backend code?

You probably know how it goes. The API and the backend come first. The app engineers wait. When the API is finally released, they start building, and only then do the first questions and issues show up. By that time, the backend engineers have already moved on to something else.

This is the story of how my team at Hemnet tried to do it differently, and what we learned along the way.

## What App-First meant for us

At Hemnet we have a principle called **App-First**. It means: find ways to enable the development and the release of new product changes in the mobile app first, and on web and desktop later.

In the conventional way of working, this principle does not hold. Look at this picture, where the Y-axis is the code we write and the X-axis is the time:

![The conventional workflow: backend API work first, app work later](/assets/app-first-conventional-workflow.png)

The blue line is the backend API work, the yellow line is the app work. The backend goes first, and the app has to wait. The small gaps where blue and yellow take turns are the app engineers finding something missing or wrong, and the backend engineers going back to code they "finished" weeks before.

While working this way, we observed three things that were not working:

1. **The App-First principle did not hold.** The app was always the last one in the line.
2. **Feedback was delayed** to the very end, when the whole API was already implemented.
3. **Context switching.** The backend engineers released the whole implementation, moved on to other product changes and tasks, and then had to switch back when the feedback from the app arrived.

## From principle to practice

So we asked ourselves: if we want to be app-first, what should we actually do? We came up with three goals:

1. **Enable the app development as soon as possible.**
2. **Shorten the feedback loop**, to find and fix issues earlier in the process.
3. **Reduce, or remove, the context switches.**

In other words, we wanted to go from the picture above to this one:

![Backend and app development in parallel, early on the market](/assets/app-first-parallel-development.png)

Backend and app work **at the same time**, and the product change reaches the users earlier.

## Fake the API first

We had a good opportunity to try it: a full redesign of a relevant part of the GraphQL API, together with a new important product feature, released on iOS. The API was more than three years old, and both our domain language and our GraphQL knowledge had evolved since then.

This is how we proceeded:

1. **Agree on a first API draft.** It doesn't have to be perfect. We discussed the draft schema in one long thread, until it was _good enough_ to start.
2. **Release the fake API in production.** Same schema, fake data. From that moment on, the app engineer could build against a real endpoint.
3. **Incremental API implementation, with continuous app feedback.** The backend engineer replaced the fake parts with the real implementation, one query or mutation at a time. Meanwhile, the app engineer kept asking questions and spotting issues, and we fixed them right away, while the code was still fresh in our heads.
4. **Fully working API and app**, in about two sprints[^1].

![Incremental API releases replacing the fake API, while backend and app work in parallel](/assets/app-first-incremental-with-fake-api.png)

**The fake API was the enabler.** Every incremental release replaced a piece of the fake API, and the API design kept improving based on direct feedback from the app engineer.

## What we gained

Compared to the conventional way of working, full API first and app development later, we reduced the **time-to-market to almost half**. The feedback was not delayed anymore, and there was **no context switching and no rework** at the end: the changes coming from the app feedback were applied while we were building the actual implementation.

In the end, we had a fresh GraphQL API (43 new types, 2 new queries and 6 new mutations) and a new product feature released on iOS.

## Lean principles in practice

Looking at it now, the approach is a small application of some of the principles of _Lean Software Development_[^2]:

- **Eliminate waste.** The waiting for the API, the task switching, and the rework that comes from late feedback are all forms of waste.
- **Amplify learning.** A tight feedback loop turns every question from the app into a design improvement.
- **Decide as late as possible.** We did not aim for the perfect API at first. We committed to a draft, and let the real usage shape the final design.
- **Deliver as fast as possible.** Parallel work means the product change reaches the users earlier.
- **Build integrity in.** The API and the app grew together, so they fit each other by design, not by a final round of fixes.

## It only works with tight collaboration

A fake API alone does not make all of this happen. What made it work for us is that **we are one cross-functional team**. The app engineer and the backend engineer were in constant contact: short threads about a specific mutation, quick updates on what was released and what was next, and small, frequent releases.

**Communication is important.** If backend and app are two separate teams that talk once a week, the fake API will only move the waiting somewhere else. Practices like **pair and mob programming**, and cross-functional teams, are what keep the feedback loop tight.

## What hurt, and what changed since then

It was not all smooth. At the time, **faking the API was the most tedious part**: it took time to implement, knowing that we were going to throw it away. Back then I wished we had **a GraphQL mock server available in production**, to test out an API design more quickly.

But these observations are from more than a year ago, when AI was not yet mature enough to assist us in writing code. Today, with our [agentic workflow]({% post_url 2026-10-15-agentic-workflows-the-workflow-was-already-there %}), the time we spend typing code is close to zero, so **faking an API is no longer the tedious part**.

There is more. The agentic workflow moved most of our time into **defining the specification**. That is exactly where the first API draft lives: we can spend that time, together with the app engineers, outlining a better version of the API we expect to use from the app's point of view, before the fake one is even released.

The approach is lightweight, and it fits well with new APIs and new features. On the app side, a feature flag keeps the new feature hidden from the users until it is fully implemented.

## Try it on your next feature

Next time a product change goes across the app and the backend, try this with your team:

1. **Sit together with the app engineers** and draft the API. Stop when it is good enough to start, not when it is perfect.
2. **Fake it and release it in production.** The API needs no feature flag: it is the app that keeps the new feature behind one, until it is ready for the users.
3. **Replace the fake one piece at a time**, and treat every question from the app as an input for the API design.

## References

[^1]: At that time, our team's sprints were two weeks long.
[^2]: Mary Poppendieck and Tom Poppendieck, _Lean Software Development: An Agile Toolkit_, Addison-Wesley, 2003.
