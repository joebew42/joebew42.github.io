---
layout: post
title: "aido: A Spec-First, Test-Driven Agentic Workflow"
date: 2026-12-15 9:00:00 +0100
tags: [augmented-engineer]
summary: "aido is the agentic workflow I use every day, at work and on side projects. Here is what it is, how it differs from other agentic workflows, and where it falls short."
---

> aido is the agentic workflow I use every day, at work and on side projects. Here is what it is, how it differs from other agentic workflows, and where it falls short.

<!--more-->

Maybe you have already tried a coding agent, with a prompt or its plan mode, and got some working code. Then you started to wonder how to make it more **structured** and **disciplined**, closer to the way a software engineer would work.

That was the question behind [aido](https://github.com/joebew42/aido). It grew out of the workflow my team built over the last year, which I described in [Agentic Workflows: The workflow was already there]({% post_url 2026-10-15-agentic-workflows-the-workflow-was-already-there %}), and it has evolved quite a bit since then. Today I use it at work and on personal projects. This post is one person's experience with one tool, not a review of the others.

## What aido is

aido is a plugin for Claude Code and GitHub Copilot CLI. It turns the steps of shipping a change into five skills:

1. **Plan**: draft and approve the specification and the plan.
2. **Implement**: build the feature test-first, and check every acceptance criterion.
3. **Organize commits**: turn the work into a clean, reviewable history.
4. **Open PR**: verify, push with your approval, and open the pull request.
5. **Handle review**: decide, comment by comment, whether to fix, answer, or park it in an issue.

The idea behind it is **delegate the work, not the judgement**. The agent writes the specification, the tests, the code and the pull request. The human decides what gets built, and owns the result.

## The specification at the center

The workflow revolves around one file, `SPEC.md`. It says why (_Context_), what (_Intent_), what not (_Out of scope_), and lists numbered **acceptance criteria**. Planning adds how, as a plan. Every other skill reads it. A few things follow from this:

- **The human approves what matters**: the draft, the specification and the plan.
- **Each skill can start from a fresh context**, picking up from `SPEC.md` and the git history instead of a long conversation.
- **The acceptance criteria stay visible** until implementation checks them all.
- **Someone else checks the result.** `/aido:verify` checks a branch against the specification in a fresh context, so the agent that built it is not the judge.

The way I see it, this keeps the workflow focused and grounded on engineering practices, with the repository's own conventions (`CLAUDE.md`, `AGENTS.md`) taking precedence over aido's.

## Keeping the codebase healthy

An agent can produce a lot of code, and complexity, in a short time. So aido tries to keep the codebase healthy **every time we work on a code change**, not as a separate clean-up project:

- **Assess the architecture.** `/aido:assess-architecture` looks, area by area, for duplicated knowledge, misplaced ownership, reinvented abstractions and crossed boundaries. The findings I pick come back when a planned change touches the same code, so each refactoring ships with a working feature.
- **Prepare the change.** While planning, aido can look for _preparatory_ (or enabling) refactorings. As Kent Beck put it: _"make the change easy, then make the easy change"_.
- **Refactor after the change.** A final design review looks at the whole diff. The refactorings I accept are built in small steps, with the tests green after each.

The analysis can take a while, so it is offered, not forced, and finding nothing is a normal outcome.

## How it differs from other workflows

Here is how aido compares with three common ways of working, as far as I can tell from their documentation.

**Prompting, or plan mode.** The plan lives in the conversation and is gone when it ends, with no explicit acceptance criteria, and tests up to the agent. aido writes the plan down and makes tests part of the implementation.

**[Spec Kit](https://github.com/github/spec-kit)** is also spec-driven, but it is a broad toolkit: several processes you can customize, or replace with your own. aido is narrower and more opinionated: one path, with TDD built in, that goes past the code into the commits, the pull request and the review.

**[BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD)** covers the whole effort, from early ideas to delivery, with specialized perspectives such as product, architecture and UX. aido covers a smaller part: from an agreed specification to a merged pull request, one small change at a time.

In short, **aido does not try to cover everything**: it focuses on one change, the health of the code around it, and the engineer in the loop.

## Where it falls short

- **It does not work well on long or big tasks.** It is designed for small, well-scoped changes. A bigger feature has to be split into phases first (see below).
- **It assumes a human in the loop.** In Copilot CLI, the approvals are reliable only in an interactive session.
- **It is opinionated.** If you don't want to work test-first, or don't work with pull requests on GitHub, much of it won't fit.

## Try it on a small change

To try a spec-first way of working, with or without aido:

1. **Pick a small, well-scoped change** from your backlog.
2. **Before any code, write down the intent, what is out of scope, and a few numbered acceptance criteria**, and ask the agent to work from them.
3. **When the agent is done, go through the criteria one by one** and check that the result meets each of them.
4. **Compare it with how the same change would have gone** with your usual way of working.

## aido super powers

A few skills go beyond a single, small change:

- **Deliberate.** Before planning, `/aido:deliberate` asks two agents for a design, one aiming for the best and one for the simplest, and a third compares them and recommends one. It uses an expensive model, so I keep it for designs that really need exploring.
- **Multi-phase.** `/aido:multi-phase-plan` splits a feature too big for one pull request into phases, tracked by a main pull request. Each phase goes through the normal flow, and independent ones can run in parallel, in separate git worktrees.
- **Stabilize.** `/aido:stabilize` takes over work done outside the workflow, such as a proof of concept or an existing pull request, and brings it in line with the guidelines. See also [Spike and Stabilize]({% post_url 2026-11-15-spike-and-stabilize-two-modes-for-product-development %}).

## References

- [aido](https://github.com/joebew42/aido)
- [Spec Kit](https://github.com/github/spec-kit), by GitHub
- [BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD), by BMad Code
- [Agentic Workflows: The workflow was already there]({% post_url 2026-10-15-agentic-workflows-the-workflow-was-already-there %})
- [TDD and Coding Agents: Is It Theater?]({% post_url 2026-11-08-tdd-and-coding-agents-is-it-theater %})
