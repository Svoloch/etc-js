
$Arr = do->
	mix = (Super = [].constructor)->
		class $Arr extends Super
			constructor: (args...)-> #no idiotic case when single argument is the value of length
				super()
				@push args...
		for name, method of mix.proto
			$Arr::[name] = method
		for name, method of mix.base
			$Arr[name] = method
		$Arr
	mix.proto =
		unique: 
			if typeof Set == 'function'
				->
					result = new @constructor
					set = new Set
					@forEach (item)-> unless set.has item
						set.add item
						result.push item
					result
			else
				->
					result = new @constructor
					@forEach (item)-> if item not in result
						result.push item
						result
		find: (fn, self)->
			for val, pos in @[..]
				return val if fn.call self, val, pos, @
			return
		findIndex: (fn, self)->
			for val, pos in @[..]
				return pos if fn.call self, val, pos, @
			-1
		findLastIndex: (fn, self)->
			for val, pos in @[..].reverse()
				return @length - pos if fn.call self, val, pos, @
			-1
		fillm: (val, from = 0, to = -1)->
			from = if from > 0 then from else @length + from
			to = if to > 0 then to else @length + to
			from = Math.ceil Math.min from, @length
			to = Math.min to, @length
			while from < to
				@[from++] = val
			@
		unzip: (keys, dest)->
			dest = {} if argument.length < 2
			if keys?
				for key, cond of keys when cond
					dest[key] = new @constructor
					dest[key].length = @length
				for value, pos in @
					for key, cond of keys when cond
						dest[key][pos] = value[key]
			else
				for value, pos in @
					for own key of value #
						dest[key] ?= new @constructor
						dest[key][pos] = value[key]
			dest
	mix.base =
		patch: (arr)->
			try
				arr.constructor = @
				arr.__proto__ = @::
			catch
				new @constructor #useful for `null` and `undefined` values returned from regular expressions
		mix: mix
	do mix
module.exports = $Arr if module?.exports?
