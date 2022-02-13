.PHONY: all web es6 node test clear
all: web es6 node
web: dist/web/function.js dist/web/promise.js dist/web/cell.js dist/web/memoise.js
es6: dist/es6/function.js dist/es6/promise.js dist/es6/cell.js dist/es6/memoise.js
node: dist/node/function.js dist/node/promise.js dist/node/cell.js dist/node/memoise.js
test: node
	coffee function-test.coffee ru
clear:
	rm dist/web/function.js
	rm dist/web/promise.js
	rm dist/web/cell.js
	rm dist/web/memoise.js
	rm dist/es6/function.js
	rm dist/es6/promise.js
	rm dist/es6/cell.js
	rm dist/es6/memoise.js
	rm dist/node/function.js
	rm dist/node/promise.js
	rm dist/node/cell.js
	rm dist/node/memoise.js
dist/web/function.js: function.coffee
	grep -v -P "###!(REQUIRE|IMPORT)###" function.coffee | sed "s/###\!SCRIPT###//g" | coffee -scb > dist/web/function.js
dist/web/promise.js: promise.coffee
	grep -v -P "###!(REQUIRE|IMPORT)###" promise.coffee | sed "s/###\!SCRIPT###//g" | coffee -scb > dist/web/promise.js
dist/web/cell.js: cell.coffee
	grep -v -P "###!(REQUIRE|IMPORT)###" cell.coffee | sed "s/###\!SCRIPT###//g" | coffee -scb > dist/web/cell.js
dist/web/memoise.js: memoise.coffee
	grep -v -P "###!(REQUIRE|IMPORT)###" memoise.coffee | sed "s/###\!SCRIPT###//g" | coffee -scb > dist/web/memoise.js
dist/es6/function.js: function.coffee
	grep -v -P "###!(REQUIRE|SCRIPT)###" function.coffee | sed "s/###\!IMPORT###//g" | coffee -scb > dist/es6/function.js
dist/es6/promise.js: promise.coffee
	grep -v -P "###!(REQUIRE|SCRIPT)###" promise.coffee | sed "s/###\!IMPORT###//g" | coffee -scb > dist/es6/promise.js
dist/es6/cell.js: cell.coffee
	grep -v -P "###!(REQUIRE|SCRIPT)###" cell.coffee | sed "s/###\!IMPORT###//g" | coffee -scb > dist/es6/cell.js
dist/es6/memoise.js: memoise.coffee
	grep -v -P "###!(REQUIRE|SCRIPT)###" memoise.coffee | sed "s/###\!IMPORT###//g" | coffee -scb > dist/es6/memoise.js
dist/node/function.js: function.coffee
	grep -v -P "###!(IMPORT|SCRIPT)###" function.coffee | sed "s/###\!REQUIRE###//g" | coffee -scb > dist/node/function.js
dist/node/promise.js: promise.coffee
	grep -v -P "###!(IMPORT|SCRIPT)###" promise.coffee | sed "s/###\!REQUIRE###//g" | coffee -scb > dist/node/promise.js
dist/node/cell.js: cell.coffee
	grep -v -P "###!(IMPORT|SCRIPT)###" cell.coffee | sed "s/###\!REQUIRE###//g" | coffee -scb > dist/node/cell.js
dist/node/memoise.js: memoise.coffee
	grep -v -P "###!(IMPORT|SCRIPT)###" memoise.coffee | sed "s/###\!REQUIRE###//g" | coffee -scb > dist/node/memoise.js
