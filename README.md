Useful code collection for JavaScript platforms
==

Prehistory
--
Long time writing JS code I collect reusable code fragments into one file for easely copying. Then this collection grows to sizes to be library.

The basic concept
--
Function is the same value as other types and can be calculated.

All functions use `this` and can be used like methods. So calculated functions must use `this` and be methods.

Features of implementation
--
Most of used alhorithms use elementary abilities. So ECMAScript5 abilities are not needed. Library can be used with ECMAScript3.

Library architecture means to use library as it is. Without modification of code but using additions. You can change any function or method by modifed or your own one. Also you can extend library and apply to it the inherit pattern.

Why CoffeeScript
--
The library may be written in pure JavaScript but CoffeeScript is simpler, shorter and faster. Not sense to make problems for myself.

Most of code examples written in CoffeeScript. If you have questions about CoffeeScript code you can convert it to JavaScript by webinterface in [coffeescript.org].

`$F`
--
It is bad idea to modify `Function.prototype`, better to use `$F` decorator. It create from function new function doing the same but with extend API. So you able to use original function in other parts of code by same way as you done. It allow you to use other function based types with this library.

`$F.prototype`
--
Was question how to name the function added other API to functions. Also prototype of function must be function else some object oriented abilities not work. Thus I solved this problems by one feature.

`$F.prototype.then`
--
Allows after current function execution to call other function with current function result like first argument.
It may looks like change order of execution unary functions.
```coffeescript
do $F(->"example").then(alert)
```
works like
```coffeescript
alert "example"
```

`$F.prototype.catch`
--
Exceptions is the same result of calculating alhoruthm as returned value. More, it is part of API of standart liberis and meny others. So like result it may be returned.

`catch` function attaches expeption processor to current function allowing to use execution in following calculations.
```coffeescript
parseJSON = $F(JSON.parse).catch ->null
```
works identical to
```coffeescript
parseJSON = (str)->
	try JSON.parse str
	catch then null
```

`$F.prototype.bind`
--
This ECMAScript5 function returns the function value. So better result function have the same API as original. Also, in ECMAScript3 it would be useful too.

`$F.prototype.bindArgs`
--
Returns the function were applied passed arguments. Other argument you can pass to result.

`$F.prototype.bindArgsStrict`
--
The same as `bingArgs` but rest arguments are ignored.

`$F.prototype.catchCond`
--
Catches exceptions by condition.

`$F.prototype.catchVal`
--
Catches exception if it equal to passed value.

`$F.prototype.catchType`
--
Catches exception by type.

`$F.prototype.default`
--
Function returns passed value on exception.
`$F.prototype.loop`
--
Repeat passed function until exception.

`$F.prototype.times`
--
Repeat function and return array with results.

First argument is times, second is `this`.
```coffeescript
$F(->"\t").times(10).join ""
```
works like
```coffeescript
(for x in [0...10] then "\t").join ""
```

`$F.prototype.repeat`
--
Works like `times` but return the same function.

`$F.prototype.curry`
--
Curry function by one argument per call.

`$F.prototype.bindedCurry`
--
The same as `curry` but `this` binded at first call.
`$F.prototype.curryBreak`
--
Break arguments list by fragments and curry by them.
`$F.prototype.preprocessAll`
--
Applies the function to argument list and pass result as arguments to current function.

`$F.prototype.flip`
--
Changes arguments order.

`$F.prototype.preprocess`
--
Applies passed function to argument in the same position.

`$F.prototype.preprocessStrict`
--
The same `preprocess` but not processed arguments ignored.

`$F.prototype.guard`
--
Checks result by condition. Throw `Error` exception on false.

`$F.prototype.guardType`
--
Checks result by type.

`$F.prototype.guardArgs`
--
Checks each argument by condition functions.

`$F.prototype.guardArgsTypes`
--
Checks arguments by type list.

`$F.prototype.zipper`
--
Returns function from array list that apply original function for each index until array not finish.

`$F.prototype.zip`
--
Zip passed arrays by current function.

`$F.prototype.zipWith`
--
The same as `zip` but use first argument like `this`.

`$F.prototype.objectZipper`
--
The same as `zipper` but for objects. Also you can set object for change fields.

`$F.prototype.zipObjects`
--
The same as `zip` for objects.

`$F.prototype.zipObjectsWith`
--
The same as `zipWith` for objects.

`$F.prototype.zipObjectsTo`
--
The same as `zipObjects` but fields change in first argument using rest arguments.

`$F.prototype.cell`
--
Creates cell object like in some Clojure liberis. Arguments used as relative cells.

`$F.prototype.fnFlip`
--
Changes order of call off function returning function.

`$F.commonKeys`
--
Useful function used in `objectZipper`. 

`$F.as`
--
Detect the first argument is a instance of second. Works for types as constucrors and types as strings by `typeof`.

`$F.cell`
--
Creates the cell for setting value.

`$F.inherit`
--
Creates decorator with the same behavior as `$F`. It is the children of `$F`

`$F.Error`
--
Exception used inside the library.

[coffeescript.org]:http://coffeescript.org