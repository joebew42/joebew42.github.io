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

...
