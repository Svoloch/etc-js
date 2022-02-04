
export default ($F)->###!IMPORT###
do($F)->###!SCRIPT###
module.exports = ($F)->###!REQUIRE###
	$F.prototype.promiseToCallback = ->
		fn = @
		$F (args...)->
			cb = args.pop()
			if(typeof cb != "function")
				return fn args..., cb
			cb = cb.bind @
			fn = fn.bind @
			Promise.resolve()
				.then ()=> fn args...
				.then (x)=> cb null, x
				.catch (x)=> cb x
			@
	$F.prototype.callbackToPromise = ->
		fn = @
		$F (args...)->
			new Promise (done, fail)=>
				fn.call @, args..., (err, data)=>
					if err?
						fail err
					else
						done data
	@
