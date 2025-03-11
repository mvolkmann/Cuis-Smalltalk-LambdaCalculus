# Cuis-Smalltalk-LambdaCalculus

This demontrates implementing Lambda Calculus functions in Smalltalk.
It is based on talk I have given on Lambda Calculus.
The slides can be found at
https://github.com/mvolkmann/talks/blob/master/lambda-calculus.key.pdf.

The slides show many Lambda Calculus functions
in their original syntax and in JavaScript.
Implementations of all the JavaScript functions
and unit tests for them can be found at
https://github.com/mvolkmann/lambda-calculus/blob/main/lambda-calculus.test.ts.
The Cuis Smalltalk `LambdaCalculus` package here
replicates the JavaScript functions and their unit tests.

In Lambda Calculus, all you have are functions.
There are no data types for Booleans, numbers, strings,
or any other data type you can think of.
All the functions take a single argument which is a function
and they return a single value which is a function.

Despite these severe limitations, it is possible to define
functions that represent Boolean values and whole numbers.
These include:

- `true\_` - underscore added to avoid conflicting with Smalltalk `true`
- `false\_` - underscore added to avoid conflicting with Smalltalk `false`
- `zero`, `one`, `two`, ...

It is also possible to define operations on those values including:

- `not`
- `and`
- `or`
- `succ` - successor of a number
- `pred` - predecessor of a number
- `pair` - of values
- `fst` - first value in a pair
- `snd` - second value in a pair
- `add`
- `sub` - subtract
- `mul` - multiply
- `exp` - exponentiation (`exp`)
- `compose` - two functions
- `iszero` - test if a number is zero
- `factorial` - using Y-combinator
- `bool` - converts a Lambda Calculus Boolean to a Smalltalk boolean
- `num` - converts a Lambda Calculus number to a Smalltalk number

Each of these functions are implemented as Smalltalk blocks.
They are defined in the `LC` class in its class method `initialize`
and are added to a class variable `Dictionary`.
The blocks can be retrieved by sending `#block:` to the `LC` class.
The point of this is not to be elegant or efficient,
but to show what is possible when all you have are functions.

For example:

```smalltalk
two := LC block: #two.
three := LC block: #three.
add := LC block: #add.
num := LC block: #num.
num value: (add value: two :: value: three) :: print. "prints 5"
```

All the unit tests are defined in the `LCTests` class.
They can be executed by opening a "SUnit Test Runner" window.
