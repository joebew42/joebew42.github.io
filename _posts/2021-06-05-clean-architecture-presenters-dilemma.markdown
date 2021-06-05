---
layout: post
title: "Clean Architecture and the Presenter dilemma"
date: 2021-06-05 9:00:00 +0100
tag: programming
summary: "I am going to share some of my learnings on Clean Architecture, Presenters, and some design decisions."
---

> I am going to share some of my learnings on Clean Architecture, Presenters, and some design decisions.

During this time I have been busy studying the book ["Clean Architecture"](https://www.goodreads.com/book/show/18043011-clean-architecture) by [Robert C. Martin](https://twitter.com/unclebobmartin). Together with [Matteo Pierro](https://twitter.com/matteo_pierro) and [Piero Di Bello](https://twitter.com/pierodibello) we started an [online book club](https://www.youtube.com/channel/UCmPAZClDMjkqxjsqPfhqOxg/videos) (it's in Italian) discussing each chapter of the book, followed by hands-on sessions to apply our learnings on a real-life project.

The topic that I found more difficult to grasp is the one related to the separation between the domain logic and its presentation. In Clean Architecture, this separation is achieved through _Presenter_, _ViewModel_, and _View_ (read chapter 23 on "Presenters and Humble Objects").

What puzzled me the most, and we will see later where this source of confusion originated, and what are the teachings I have drawn, is the fact that in the book there is no trace of code where you can look at to understand how this separation can be practically translated into code.

If that wasn't enough, the book offers a few design diagrams to show how Presenters, ViewModel, and View can be organized. We will discover that different design choices have pros and cons and that a clean architecture is more tied to a principle, rather than a rigid framework to adhere with.

## The Presenter, ViewModel, and View dilemma

For our hands-on session, we decided to build a [**TODO application**](https://github.com/MatteoPierro/clean-todo). An application that can be used to manage a TODO list, and we started from the use case for creating new todos: The `AddTodoUseCase`.

While we were thinking and working on the UseCase, we decided to follow the design proposed in chapter 22 on "The Clean Architecture" of the book:

![](https://i.imgur.com/rPAABIw.jpg)

We evaluated different options for the Presenter, ViewModel, and View flow.

## Option 1: The Observer pattern

At first, and I would say naively looking at this diagram, it comes quite naturally to use the [**Observer pattern**](https://en.wikipedia.org/wiki/Observer_pattern) where the View was the Observer and the ViewModel the Observable.

Implementing an observer mechanism was not straightforward and [the resulting code was more complex than expected](https://github.com/MatteoPierro/clean-todo/blob/bd224e4577ce08b78e0674bfe526ed53ba94d3c9/app/src/main/java/io/vocidelcodice/todo/apps/console/ConsoleApp.java), and I have to confess I had hard times figuring out the flow of execution.

The reason why opting for an observer isn't a great idea is because the `ViewModel` is a simple data structure object and it shouldn't have any logic, nor know anything about the `View`. Thus because of the Dependency Rule [^1]:

> _Source code dependencies must point only inward, toward higher-level policies_.

It was possible to satisfy this rule by introducing an intermediary collaborator between the `Presenter` and the `View`, which we named `ViewModelPublisher`.

In such a way that the `ViewModelPublisher` acted as an` Observer`, the `View` as an `Observer`, and the `Presenter` was responsible for creating the` ViewModel` and then notifying the view of its changes.

Here you can see part of the implementation of the `Presenter`:

```java
public class AddTodoPresenter implements AddTodoOutputBoundary {

    private final ViewModelPublisher viewModelPublisher;

    public AddTodoPresenter(ViewModelPublisher viewModelPublisher) {
        this.viewModelPublisher = viewModelPublisher;
    }

    @Override
    public void addTodoSucceeded(AddTodoOutputData addTodoOutputData) {
        AddTodoViewModel viewModel = AddTodoViewModel.success(
                successMessageFor(addTodoOutputData),
                colorForPriority(addTodoOutputData.priority)
        );
        viewModelPublisher.publish(viewModel);
    }

...
```

And what next is the ["wiring"](https://github.com/MatteoPierro/clean-todo/blob/bd224e4577ce08b78e0674bfe526ed53ba94d3c9/app/src/main/java/io/vocidelcodice/todo/apps/console/ConsoleApp.java) between the `ViewModelPublisher`, the `View`, and the `Presenter` in the main application code:

```java
...
ObservableViewModelPublisher viewModelPublisher = new ObservableViewModelPublisher();
viewModelPublisher.addObserver(new AddTodoView());
AddTodoOutputBoundary addTodoPresenter = new AddTodoPresenter(viewModelPublisher);
...
```

Some criticisms I feel like giving to this design choice are:

- It's convoluted. There are too many moving parts.
- The flow of execution is difficult to follow.
- The "wiring" part is tightly coupled with a concrete implementation of a`ViewModelPublisher`.

## Option 2: Getting rid of the Observer

During a second iteration, we decided to [rework the entire part related to Presenter, ViewModel, and View flow](https://github.com/MatteoPierro/clean-todo/blob/06af61ac556e96f8d29f49eb0c12d3a217fbc18d/app/src/main/java/io/vocidelcodice/todo/apps/console/ConsoleApp.java) trying to eliminate the implementation of the Observer pattern.

Thankfully to Matteo, he had this great intuition to let the `Presenter` directly publish the `ViewModel` changes on its `View`, without the need of an intermediate collaborator, but at the same time satisfying the _Dependency Rule_.

Looking at the diagram above we made a few changes:

![](https://i.imgur.com/lvUHS9f.png)

The Dependency Rule is still in place since the code dependency `ConsoleView` is pointing inward, and we managed to promote the `View` as a "higher-level" policy.

While the resulting code of Present might look quite similar to the previous implementation, an important detail now is that the Presenter renders changes directly to the View.

```java
public class AddTodoPresenter implements AddTodoOutputBoundary {

    private final AddTodoView addTodoView;

    public AddTodoPresenter(AddTodoView addTodoView) {
        this.addTodoView = addTodoView;
    }

    @Override
    public void addTodoSucceeded(AddTodoOutputData addTodoOutputData) {
        AddTodoViewModel viewModel = AddTodoViewModel.success(
                successMessageFor(addTodoOutputData),
                colorForPriority(addTodoOutputData.priority)
        );
        addTodoView.render(viewModel);
    }

...
```

A bigger improvement is instead achieved on the main application code, responsible of the ["wiring"](https://github.com/MatteoPierro/clean-todo/blob/06af61ac556e96f8d29f49eb0c12d3a217fbc18d/app/src/main/java/io/vocidelcodice/todo/apps/console/ConsoleApp.java) between Presenter and View:

```java
AddTodoView addTodoView = new ConsoleAddTodoView();
AddTodoOutputBoundary addTodoPresenter = new AddTodoPresenter(addTodoView);
```

We are no longer tightly coupled with a concrete implementation!

The part I liked the most here is this clearer separation between the `Presenter`, its `View`, and the different implementation of it. In the above example, we want to render our changes using a `ConsoleView`.

Compared to the Observer option, I value this solution more because:

- Reduced complexity in terms of moving parts.
- The flow of execution is now more natural to follow.
- The "wiring" part is now more clear.

## One principle, different design options

I think the biggest learning from this experience is that what matters most when working towards a _Clean Architecture_ is to always keep the _Dependency Rule_ in mind and at the same time decide on the simplest possible design that sticks to that principle.

[^1]: [The Clean Architecture Dependency Rule](https://www.informit.com/articles/article.aspx?p=2832399)
