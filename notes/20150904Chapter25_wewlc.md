# Dependency-Breaking Techniques

Here we are going to expose some refactoring techniques that helps us
to extract and test dependencies out from our code.

These techniques are good to get methods, classes, and clusters of
classes under test, to make the system more maintainable.
At that point, we can use test-supported refactorings to make the
design cleaner.

In general, these are the main steps to execute for each technique:

1. Extract code
2. Write tests
3. Refactor

> Remember: When we are writing tests for existing code we want to
> document what the software actually does and *NOT* what is supposed
> to do.

# Tecnhinques

## Adapt Parameter

Use `Adapt Parameter` when you can't use `Extract Interface` on a
parameter's class or when a parameter is difficult to fake.

Example code:

```
public void populate(HttpServletRequest request) {
  String[] values = request.getParameterValues(myValue);
  String parameter = values[0];
  ...
}
```

`HttpServletRequest` is an external interface. It is out of our
control.

We can introduce our smaller interface, which we can control
(ex. `SourceParameter`):

```
public void populate(SourceParameter source) {
  String value = source.getParameterForName(myValue);
  ...
}
```

And then provide a `Fake` or `Real` implementation based on the
environment. The `Real` implementation will work with
`HttpServletRequest`.

Move toward interfaces that communicate responsibilities rather than
implementation details. This makes code easier to read and easier to
maintain.

### Steps

1. Create the new interface that you will use in the method. Make it
   as simple and communicative as possible, but try not to create an
   interface that will require more than trivial changes in the method.
2. Create a production implementer for the new interface.
3. Create a fake* implementer for the interface.
4. Write a simple test case, passing the fake to the method.
5. Make changes you need to in the method to use the new parameter.
6. Run your test to verify that you are able to test the method using
   the fake.

* the term `fake` is meant as any `test double` object.

## Break Out Method Object

The idea behind this refactoring is to extract long method into a
separate new class. Instances of this class are called
`method objects` because they have only one method. It is easy now,
to put this class under test. Local variables on the old method become
instance variables in the new class. Often this kind of refactoring
makes easier break out dependencies and put the code in a bettter
state.

### Steps

1. Create a class that will house the method code.
2. Create a constructor for the class and `Preserve Signatures` to
   give it an exact copy of the arguments used by the method. If the
   method uses an instance data or methods from the original class,
   add a reference to the original class as the first argument to the
   constructor.
3. For each argument in the constructor, declare an instance variable
   and give it exactly the same type as the variable.
   `Preserve Signatures` by copying all the arguments directly into
   the class and formatting them as instance variable declarations.
   Assign all of the arguments to the instance variables in the
   constructor.
4. Create an empty execution method on the new class. Often this
   method is called `run()` or `execute()`, or one more suitable based
   on your domain.
5. Copy the body of the old method into the execution method and
   compile to `Lean on the Compiler`.
6. The error messages from the compiler should indicate where the
   method is still using methods or variables from the old class.
   In each of these cases, do what it takes to get the method to
   compile. In some cases, this is as simple as changing a call to
   use the reference to the original class. In other cases, you might
   have to make methods public on the original class or introduce
   getters so that you don't have to make instance variables public.
7. After the new class compiles, go back to the original method and
   change it so that it creates an instance of the new class and
   delegates its work to it.
8. If needed, use `Extract Interface` to break the dependency on the
   original class.
