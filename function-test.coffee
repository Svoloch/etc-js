$F = require './function'

$L = $F(console.log).bind console
test = $F (args...)->args.join ""

$L "сшивка массивов"
$L JSON.stringify test.zip [1,2,3],[4,5,6,0],[7,8,9]
$L JSON.stringify ["147","258","369"]
$L((JSON.stringify test.zip [1,2,3],[4,5,6,0],[7,8,9]) == (JSON.stringify ["147","258","369"]))

$L "сшивка с заменой аргумента"
$L test.preprocess(->"#").zip [0..1],[1,2,3],[4,5,6,0],[7,8,9]
$L test.bindArgs("#").zip [1,2,3],[4,5],[7,8,9]
$L (JSON.stringify test.preprocess(->"#").zip [0..1],[1,2,3],[4,5,6,0],[7,8,9]) == (JSON.stringify test.bindArgs("#").zip [1,2,3],[4,5],[7,8,9])

$L 'смена порядка аргументов'
$L test.flip(0,2) 0,1,2,3,4,5
$L test 2,1,0,3,4,5
$L (test.flip(0,2) 0,1,2,3,4,5) == (test 2,1,0,3,4,5)
$L test.flip(4,1) 0,1,2,3,4,5
$L test 0,4,2,3,1,5
$L (test.flip(4,1) 0,1,2,3,4,5) == (test 0,4,2,3,1,5)

$L "типы"
$L not do $F.as
$L $F.as 0, Number
$L $F.as "", String
$L $F.as test, $F
$L not $F.as String, $F
$L $F.as Number, "function"
$L $F.as NaN, "number"

$L "проверка then"
$L test.then((x)->"(#{x})").zip [1,2,3],[4,5,6,0],[7,8,9]

$L "проверка catch"
$L $F(JSON.parse).catch(->null) ""

$L "проверка loop"
$L do $F(->5).loop(
	(x)->
		$L x
		throw "end" if x < 0
		x-1
).then((x)->"the #{x}")

$L "каррирование"
$L test.curry(5)(0)(1)(2)(3,4)(5)

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
