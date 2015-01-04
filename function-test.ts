/// <reference path="./function.d.ts"/>
import $F = require('function');

var $L = $F(console.log).bind(console);

var test = $F((...args: any[]) => {
    return args.join("");
});

$L("сшивка массивов");
$L(JSON.stringify(test.zip([1, 2, 3], [4, 5, 6, 0], [7, 8, 9])));
$L(JSON.stringify(["147", "258", "369"]));
$L((JSON.stringify(test.zip([1, 2, 3], [4, 5, 6, 0], [7, 8, 9]))) === (JSON.stringify(["147", "258", "369"])));

$L("сшивка с заменой аргумента");
$L(test.preprocess(function() {
    return "#";
}).zip([0, 1], [1, 2, 3], [4, 5, 6, 0], [7, 8, 9]));

$L(test.bindArgs("#").zip([1, 2, 3], [4, 5], [7, 8, 9]));

$L((JSON.stringify(test.preprocess(function() {
    return "#";
}).zip([0, 1], [1, 2, 3], [4, 5, 6, 0], [7, 8, 9]))) === (JSON.stringify(test.bindArgs("#").zip([1, 2, 3], [4, 5], [7, 8, 9]))));

$L("проверка then");
$L(test.then(function(x) {
    return "(" + x + ")";
}).zip([1, 2, 3], [4, 5, 6, 0], [7, 8, 9]));
