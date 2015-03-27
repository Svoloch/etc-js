
$F = (fn)->
	($F::)(-> fn.apply @, arguments)
$F:: = (fn)->
	fn.constructor = $F
	fn.__proto__ = $F::
	fn
$F::then = (fn, args...)->
	current = @
	(@constructor::)(-> fn.call @, (current.apply @, arguments), args...)
$F::catch = (fn, args...)->
	current = @
	(@constructor::)(
		->
			try current.apply @, arguments
			catch e then fn.call @, e, args...
	)
$F::bind = if Function::bind typeof "function"
	-> (@constructor::)(Function::bind.apply @, arguments)
else ->
	current = @
	(@constructor::)(
		(self)-> ->
			current.apply self, arguments
	)
$F::bindArgsStrict = (args...)->
	current = @
	(@constructor::)(-> current.apply @, args)
$F::bindArgs = (startArgs...)->
	current = @
	(@constructor::)(
		(restArgs...)->
			args = []
			args.push startArgs...
			args.push restArgs...
			current.apply @, args
	)
$F::argToThis = (self)->
	current = @bind self
	-> current @, arguments...
$F::thisToArg = -> @call.bind @
$F::catchCond = (cond, fn)->
	@catch (e)->
		throw e unless cond.call @, e
		fn.call @, e
$F::catchVal = (val, fn)->
	@catchCond ((e)-> e == val), fn
$F::catchType = (type, fn)->
	@catchCond ((e)=> @constructor.as e, type), fn
$F::default = (value)->
	@catch ->value
$F::loop = (fn)->
	current = @
	(@constructor::)(
		->
			val = current.apply @, arguments
			try loop val = fn.call @, val
			catch e then return e
			return
	)
$F::times = (times, self)->
	index = 0
	while index++ < times
		@.call self, index
$F::repeat = (times, self)->
	index = 0
	while index++ < times
		@.call self, index
	@
$F::curry = (times = 1)->
	return @ if --times <= 0
	current = @
	(@constructor::)(
		(first)->
			current.constructor(->current.call @, first, arguments...).curry times
	)
$F::bindedCurry = (times = 1)->
	return @ if --times <= 0
	current = @
	(@constructor::)(
		(first)->
			current.constructor(=>current.call @, first, arguments...).curry times
	)
$F::curryBreak = (steps...)->
	return @ unless steps.length
	current = @
	step = steps[0]
	(startArgs...)->
		startArgs = startArgs[0...Math.max 0, step]
		(current.constructor::)(
			(restArgs...)->
				args = []
				args.push startArgs...
				args.push restArgs...
				current.apply @, args
		).curryBreak steps[1...]...
$F::preprocessAll = (fn)->
	current = @
	(@constructor::)((arr...)-> current.apply @, fn.call @, arr)
$F::flip = (from=0, to=1)->
	return @ if from == to
	[from, to] = [Math.min(from, to), Math.max(from, to)]
	@preprocessAll (arr)->
		res = []
		res.push arr[0 ... from]...
		res.push arr[to]
		res.push arr[from + 1 ... to]...
		res.push arr[from]
		res.push arr[to + 1 ...]...
		res
$F::preprocess = (fns...)->
	current = @
	(@constructor::)(
		(args...)->
			for fn, pos in fns
				args[pos] = fn.call @, args[pos]
			current.apply @, args
	)
$F::preprocessStrict = (fns...)->
	current = @
	(@constructor::)(
		(args...)->
			current.apply @, (fn.call @, args[pos] for fn, pos in fns)
	)
$F::guard = (cond)->
	@then (value)->
		throw new @Error unless cond.call @, value
		value
$F::guardType = (type)->
	@guard (value)=>@constructor.as value, type
$F::guardArgs = (conds...)->
	current = @
	(@constructor::)(
		->
			for cond, pos in conds
				throw new Error unless cond.call @, arguments[pos]
			current.call @, arguments
	)
$F::guardArgsTypes = (types...)->
	@guardArguments (
		for type in types then (value)=>
			@constructor.as value, type
	)...
$F::zipper = ->
	current = @
	(@constructor::)((arrs...)->
		for i in [0 ... Math.min (arr.length for arr in arrs)...]
			current.apply @, (arr[i] for arr in arrs)
	)
$F::zipWith = (self,arrs...)->
	@zipper().apply self, arrs
$F::zip = (arrs...)->
	@zipper() arrs...
$F::objectZipper = (defDest)->
	current = @
	(@constructor::)(
		(objs...)->
			keys = current.constructor.commonKeys objs...
			dest = defDest ? {}
			for key in keys
				dest[key] = current.apply @, (obj[key] for obj in objs)
			dest
	)
$F.commonKeys = (objs...)->
	keys = for obj in objs
		(key for key of obj).sort()
	res = []
	try loop
		break unless keys[0].length
		less = keys[0][0]
		pos = 0
		while pos < keys.length
			do keys[pos].shift while keys[pos].length && keys[pos][0] < less
			throw null unless keys[pos].length
			if keys[pos][0] > less
				less = keys[pos][0]
				pos = 0
				continue
			pos++
		res.push less
		for key in keys then do key.shift
	res
$F::zipObjects = (objs...)->
	@objectZipper() objs...
$F::zipObjectsWith = (self, objs...)->
	@objectZipper().apply self, objs
$F::zipObjectsTo = (dest, objs...)->
	@objectZipper(dest) objs...
$F::cell = (params...)->
	current = @
	value = null
	changed = false
	destroyed = false
	do recalc = ->
		throw new current.Error() if destroyed
		changed = false
		value = current (for param in params then do param)...
	res = (@constructor::)(-> unless changed then value else do recalc)
		.catch (e)->
			changed = true
			throw e
	for param in params then param.relateds.push res
	res.relateds = []
	res.recalc = recalc
	res.markChange = ->
		return res if changed
		changed = true
		for related in res.relateds
			do related.markChange
		res
	res.destroy = ->
		for param in params
			param.relateds = (item for item in param.relateds when item != res)
	res
$F.cell = (value)->
	res = (@::)(
		(newValue)->
			if arguments.length
				if value != newValue
					value = newValue
					for related in res.relateds
						do related.markChange
			value
	)
	res.relateds = []
	res.recalc = -> value
	res
$F.as = ($F::)(
	(value, type)->
		(typeof value == type) or (value instanceof type) or (value.constructor == type)
	).default false
$F.Error = class Error
	toString:->"not implemented!"

module.exports = $F if module?.exports?

#Experimental
$F::fnFlip = ->
	current = @
	(fstArgs...)->
		fstThis = @
		(sndArgs...)->
			(current.apply @, sndArgs).apply fstThis, fstArgs
$F.inherit = ->
	Type = (fn)-> (Type::)(-> fn.apply @, arguments)
	Type:: = (@::)(
		(fn)->
			fn.constructor = Type
			fn.__proto__ = Type::
			fn
	)
	Type.constructor = Type
	Type.__proto__ = @
	Type