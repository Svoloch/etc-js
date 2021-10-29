.PHONY: all web es6 node test clear
all:	web es6 node
web: dist/web/function.js
es6: dist/es6/function.js dist/es6/promise.js
node: dist/node/function.js
test: node
	coffee function-test.coffee
clear:
	rm dist/web/function.js
	rm dist/es6/function.js
	rm dist/node/function.js
dist/web/function.js: function.coffee
	cat function.coffee platforms/web.coffee | coffee -scb > dist/web/function.js
dist/es6/function.js: function.coffee platforms/es6.coffee
	cat function.coffee platforms/es6.coffee | coffee -scb > dist/es6/function.js
dist/es6/promise.js: promise.coffee
	cat promise.coffee | coffee -scb > dist/es6/promise.js
dist/node/function.js: function.coffee platforms/node.coffee
	cat function.coffee platforms/node.coffee | coffee -scb > dist/node/function.js
