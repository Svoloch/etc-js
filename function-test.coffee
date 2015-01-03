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
$L "проверка then"
$L test.then((x)->"(#{x})").zip [1,2,3],[4,5,6,0],[7,8,9]

