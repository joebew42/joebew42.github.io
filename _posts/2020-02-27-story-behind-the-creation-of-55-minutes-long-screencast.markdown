---
layout: post
title:  "The story behind the creation of 55 minutes long screencast"
date:   2020-02-27 15:00:00 +0100
excerpt_separator: <!--more-->
---

> It took more than one year to create a 55 minutes long screencast on programming. In here I will tell you the story behind it. From the original idea to the final result.

<!--more-->

I am really grateful to [Dave Schinkel](https://twitter.com/DaveSchinkel) that gave me this extraordinary opportunity to share a video about a practical example of TDD Outside-In (_[London School](https://github.com/testdouble/contributing-tests/wiki/London-school-TDD) approach_) with [Elixir](https://elixir-lang.org/), on his [TDD TV](https://www.youtube.com/user/schinkelfamily) channel on YouTube.

Before entering the essence of this blog, I would like to give a mention to [WeDoTDD.com](http://www.wedotdd.com/); that's another creature of Dave. It's a well organized list of companies that practices Clean Code, TDD and Agile Methodologies, at their daily basis. If you're curious about these topics and you are thinking to turn your professional career into that direction, I highly recommend you to take a look!

## The video!

{% include youtube.html video="_mG7NOhYMXY" %}

The video above is available on YouTube and it is about a practical example of doing TDD Outside-In with Elixir. You can see me while doing a Code Kata meant to be repeated over and over again in order to improve our skills with the Outside-In approach. If you are curious about the technique I would invite you to go and watch it.

However, **this blog it's not about the techniques or any of the content shown in the video**. Instead, it will be about the story behind it and why I chose to demonstrate the TDD Outside-In approach, in Elixir!

I will tell you the process I followed, where I struggled the most and how I pushed myself to overcome difficulties along the journey, the strategies I have tried, my failures and my learnings, with the hope that this story can be - in somehow - beneficial for you.

## The story behind it (aka Why this video?)

It's about a little over a year ago when I met Dave while I  was doing a live coding session on [Twitch](https://twitch.tv/joebew42). That was the instant when we started a discussion about the opportunity to share a video on his TDD TV. A video about programming practices like Clean Code, TDD, Refactoring or dealing with Legacy Code.

I was extremely enthusiast to have the opportunity to organize some contents and share them back in the form of a video.

## Picking up Elixir and TDD Outside-In

Elixir was the language I was currently learning at that time and on the web was not easy to find resources and examples about programming practices (e.g. TDD, Refactoring) applied with this programming language [^1].

So I decided to give my little contribution to the Elixir community.

The topic was a bit harder to choose, since there are a lot of techincal practices, principles and terminologies in Software Development, and even if the majority aims to have a better maintanability in code, each of them tries to tackle the process from a different angle, based on the purpose.

I wanted to show a practice that could give a _sense of working application_ (not only from the point of view of the domain logic, but also from the details of having an HTTP server to expose its functionalities) from the very beginning of its development life cycle.

That's why I chose the _London School_ TDD Outside-In approach.

## Going public to reach an end

As a lazy and senior procrastinator I struggle to keep myself committed until the accomplishment of my goals. Fortunately I have developed some techniques that help me to break the habit of procrastination.

One of these techniques consist to make goals public, in such a way to advertise your goal publicly so that it will spur you to find the motivation to complete something, on time, and give back the promised to your audience.

So I looked to propose a talk at the [BEAM Languages United, Stockholm](https://www.meetup.com/L-O-B-Stockholm/events/264887137/) where I could have the chance to share the practical example of TDD Outside-In in front of a real audience!

It's a sort of _Fake it 'til you make it_ approach.

And believe or not, I made it ...

![At BEAM Languages United, Stockholm](https://secure.meetupstatic.com/photos/event/c/b/a/4/600_487132132.jpeg)

_Me while at typing things_

That was great. Great organization and great people. Hey, I also had the chance to met [Robert Virding](https://twitter.com/rvirding)! Thank you [Martin Creathorn](https://twitter.com/toeyredback) for the space and organization, and thank you [Quil](https://twitter.com/robotlolita) for your - mind blowing - presentation about ["You wouldn't fold a tree ... ?"](https://speakerdeck.com/robotlolita/you-wouldnt-fold-a-tree-dot-dot-dot).

## The creation process

This was an interesting part of the whole experience. How I ended up with the content I proposed during the presentation? I had a lot of doubts, starting from which exercise I should have done, how long the presentation should have been, and mostly important, what terms I had have to use while speaking to not led the audience into confusion?

Instead of trying to "architect" my presentation with an _up-front_ design process, I decided to keep the creating process as much _lean_ as possible, where I could have tested several ideas of the presentation and finding out improvements through each iteration. Learning by doing.

The exercise I chose to start with was the [Goose Game Kata](https://github.com/xpeppers/goose-game-kata). It's the digital version of a board game where two or more players moves their tokens long the track by rolling dice. As an additional requirement I wanted to play the game through an HTTP API.

### The "cold start"

I started to program this Code Kata following the TDD Outside-in approach. I didn't complete it the first time because few observations quickly came out:

- It took too long to setup the project
- It took too long even to reach the second feature: _"Move a player"_. I went over an hour long.
- I used a lot of terms that could have brought more confusion (Acceptance Test, Mock, Dependency Injection, and so on ...).
- The domain of the game was too complex (board, players, dice, etc ...)

I tried to reduce the scope and I ended up with a few decisions: **find out a simpler exercise**, and **reduce the vocabulary of terms I would have used during the presentation**. The latter helped me to find the proper words for a more tool oriented audience, than software development practices. I didn't want to burden them with terms they were not familiar with, and also, that didn't help with the presentation.

The messages I wanted to deliver were:

> It's possible to build application starting with a test that traverse the application from its very outermost part.

> There is no need to think about the design from the very beginning of the development. We'll see the design will emerge later on.

> It's possible to proceed the development with very little steps.

> Everything is subject to change during the development. Not only the application code, but also the tests.

> At the end, it's not a matter of tool, it's more about practices.

### The Greeting Service Kata

In order to overcome the first challenges about too much time to complete few features and the complexity of the domain, I decided to create a [Greeting Service Kata](https://github.com/joebew42/greeting-service-kata) with a simple domain logic to implement, that can be used to practice the TDD Outside-In, and keep the focus straight to the practice rather than domain logic.

Given this new exercise with a reduced scope I repeated it multiple times and I discovered few more things:

- It took too long to setup the project, so I created an [initial repository on github](https://github.com/joebew42/elixir_outsidein_tdd) with everything ready to start. If you are curious you can look through the available branches to find the code of the meetup and the one of the youtube video.
- There were a lot of "cerimonies" in code, so I have organized [all the possible code snippets](https://gist.github.com/joebew42/a5b29073f2f3e7d639f919d391dde8e8) I needed to use during the presentation to speed up the coding process.
- Sometimes I found myself lost during the process, so that I wanted to visualize and learn the process through few post-it stickies:

![TDD Outside-In Post-it train](/assets/tdd-outside-in-post-it-train.jpg)
_the process I tried to visualize using post-it stickies_

### A few iterations later ...

... and **some more questions I have asked to my collegues** about their expectations from a presentation like this, I had a more clear scope now:

- It's a practical example in Elixir
- It's a practical example of TDD Outside-In approach
- We start to test the application from its outermost part
- We proceed with baby steps
- We do refactoring as part of the development process
- We split the responsibilities between the web and the domain logic

At this point the right scope and the materials were in place, I did practice the presentation several times to be confident enough for presenting in front of a real audience.

## Let's record the screencast then

Everything was ready to record the screencast, yet I encountered another challenge. I noticed that during the recording I wasn't able to provide a _linearity_ in my speech, saying the correct thing at the right time, issues like referring to the same thing using different terms, tone of my voice and few dead time.

The only thing I wanted from a screencast was to keep the **focus on the code** (the workspace), put **only my voice on it** (no overlays or face camera) and have a **clear and linear speech** to follow.

Then I tought, hey let's [**make a video script**](/assets/tdd-outside-in-video-script.pdf) so I knew exactly what to say, when to say and what to practically show. Seriously!? Oh, that was really a _terrible_ idea, but I will tell you that at least it helped me to adjust the times, the tone of my voice and avoid to refer to the same thing using different terms.

It took **more than one month** to write down the full script of the video. Of course, I was working on this video during my spare time, from time to time.

So, I had a video script also, what can could go wrong then?

E v e r y t h i n g !

I tried to record the video while following the video script but **I was not able to appear natural**. It was quite clear I was reading things while typing at keyboard. That was 100% a fake experience!

At the end, I did it. The solution? Gently <s>archive</s> trash the video script and record the video with my own words while remember the main concept to say. The result? It worked! I did the recording in one single session.

## What I think I have learned

- If the scope of the presentation is not clear and full of unknowns, try to **practically run it - alone - from its very beginning**. A lot of answers will emerge naturally.
- **Repetition is a very effective practice**, to learn and adapt based on new discoveries and gain more confidence. Repeat the presentation over and over again it's extremely important.
- Ask yourself about **the messages you want to deliver** to your audience.
- **Know your audience**: find the proper terms to use to reach your audience.
- Ask to some of your colleagues what are their **expectations** if they were to attend a presentation like this.
- Video scripting the presentation might be an helpful exercise to sharp the speech, but it's difficult to follow and appear the more natural as possible.
- Better to write down the parts of the video where the main difficulties are and **only memorize the main concept** to say while using our own words at the moment of the recording.

## Tools I have used

- [OBS](https://obsproject.com/): To record the video.
- [Hackmd.io](https://hackmd.io/) to write down some drafts and then publish as [GitHub Gist](https://gist.github.com/).

## That's all folks

That was my journey in creating a screencast of 55 minutes. I wanted to share with you the whole story, my experiences and my learnings with the hope that my experience may be useful for someone.

What about you? What are your experiences and learnings in creating screencasts? I am curious to know more about you, on [Twitter](https://twitter.com/joebew42). Tell me what worked and what have not worked for you.

[^1]: [Good Elixir TDD resources?](https://elixirforum.com/t/good-elixir-tdd-resources/17482)