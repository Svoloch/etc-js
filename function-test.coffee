$F = require './function'
$F.use require('./cell'), require('promise')
$L = $F(console.log).bind console
test = $F (args...)->args.join ""

locale = process.argv[2]

tests = [
	{
		ru: "сшивка массивов"
		en: "zipping of arrays"
		test: ->
			$L JSON.stringify test.zip [1,2,3],[4,5,6,0],[7,8,9]
			$L JSON.stringify ["147","258","369"]
			((JSON.stringify test.zip [1,2,3],[4,5,6,0],[7,8,9]) == (JSON.stringify ["147","258","369"]))
	}
	{
		ru: "сшивка с заменой аргумента"
		en: "zipping with replacing of argument"
		test: ->
			$L test.preprocess(->"#").zip [0..1],[1,2,3],[4,5,6,0],[7,8,9]
			$L test.bindArgs("#").zip [1,2,3],[4,5],[7,8,9]
			(JSON.stringify test.preprocess(->"#").zip [0..1],[1,2,3],[4,5,6,0],[7,8,9]) == (JSON.stringify test.bindArgs("#").zip [1,2,3],[4,5],[7,8,9])
	}
	{
		ru: "смена порядка аргументов"
		en: "arguments order changing"
		test: ->

			$L test.flip(0,2) 0,1,2,3,4,5
			$L test 2,1,0,3,4,5
			$L test.flip(4,1) 0,1,2,3,4,5
			$L test 0,4,2,3,1,5
			(test.flip(4,1) 0,1,2,3,4,5) == (test 0,4,2,3,1,5) &&
			(test.flip(0,2) 0,1,2,3,4,5) == (test 2,1,0,3,4,5)
	}
	{
		ru: "типы"
		en: "types"
		test: ->
			(not do $F.as) &&
			($F.as 0, Number) &&
			($F.as "", String) &&
			($F.as test, $F) &&
			(not $F.as String, $F) &&
			($F.as Number, "function") &&
			($F.as NaN, "number")
	}
	{
		ru: "каррирование"
		en: "currying"
		test: ->
			test.curry(5)(0)(1)(2)(3,4)(5) == "01235"
	}
	{
		ru: "then"
		en: "then"
		test: ->
			$L test.then((x)->"(#{x})").zip [1,2,3],[4,5,6,0],[7,8,9]
			$L test.then((x)->"(#{x})").zip [1,2,3],[4,5,6,0],[7,8,9]
			true
	}
	{
		ru: "проверка default"
		en: "default"
		test: ->
			$L $F(JSON.parse).default("error") ""
			"error" == $F(JSON.parse).default("error") ""
	}
	{
		ru: "catch"
		en: "catch"
		test: ->
			do $F(->throw true).then(->false).catch((x)->x)
	}
	{
		ru: "loop"
		en: "loop"
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
	{
		ru: ""
		en: ""
		test: ->true
	}
]
$L "проверка loop"
$L do $F(->5).loop(
	(x)->
		$L x
		throw "end" if x < 0
		x-1
).then((x)->"the #{x}")

$L "клетки"
a = $F.cell 0
b = $F.cell 0
c = test.cell a, b
$L do c
a 1
b 2
$L do c
c 5
$L do c
a 6
$L do c

$L test.curryBreak() == test
$L JSON.stringify test.curryBreak(0)()()
$L test.curryBreak(2,3)(0,0,0,0,0)(1,1,1,1,1)(2,2,2,2,2)

$F.test = "Type"
$F::test = "Proto"
G = do $F.inherit

$L G(->) instanceof $F, G.test, G().test, ((G::)(->)).test

tests.forEach (test)->
	msg = test[locale]
	$L "[", msg, "]:"
	do $F(test.test)
		.then $L.bindArgs msg, " = "
		.catch $L.bindArgs msg, " Exeption: "
