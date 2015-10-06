# Patterns for Test-Driven Development

- What do we mean by testing ?
- When do we test ?
- How do we choose what logic to test ?
- How do we choose what data to test ?

## Isolated tests

- Make the tests so fast to run that  I can run myself, and run them
  often. In this way we can catch errors as soon as possible and fix
  the code.

- Tests should be able to ignore one another completely. Isolated
  tests are ordered indipendent. One broken test is one problem,
  Two broken tests are two problems.

## Test List: What should you test ?

Write a `list` of the new things that are supposed to be implemented,
for each of these, write the kind of tests you think are needed,
considering the `null` case. Then, try to follows this list by keeping
it up to date with new requirements (e.g. refactoring). Keep focus on
this list.

At the end of the programming session and take care of which is left
on the list during the next programming session. If you have
discovered a large refactorings that are out of the scope, put them
at the end of the list or in another `later list`.

## Test First: When should you write tests ?

Before you write code that is to be tested.

## Evident Data: How do you represent the intent of the data ?

Making it explicit. Don't put magic values inside your tests, rather
than, try to give to your values some meaningful names that are
related to the context.

# Red Bar Patterns

## One Step Test: Which test should you pick next from the list ?

Pick the first one that gives you something new and that you are
confident about its implementation.

## Starter Test: Which test should you start with ?

Start by looking at the initial and trivial one that you are quickly
to get to work and learn something about the domain.

## Do Over: What to do when you are feeling lost ?

Throw away the code and start over.

# Testing Patterns

- **Child Test**
 Sometimes big tests takes minutes to get them pass/work, and results
 difficult to mantain a fast feedback loop `red/green/refactoring`.
 If you have a test that is going to be too big (it needs several
 objects in place to make it works), try to find a `child test`:
 A smaller test case that is contained in the bigger one. Or, try
 to throw away the bigger one an start writing smaller tests, one for
 each object that is used the bigger test.
 Lets say that the bigger test `A` needs objects `B`, `C` and `D`, so,
 in this case we can extract tests for `B`, `C` and `D`. And, once we
 have confident about three child tests we can back on the bigger
 test, or, simply we realize that is is not needed anymore and delete
 it.

- **Crash Test Dummy**
_Code that is not tested does not work_. How do you test error code
that is unlikely to be invoked? Invoke it anyway with a special case
that  will throws the exception. What about the odd conditions? Do you
want to test them, too? _Only if you want them to work_.
