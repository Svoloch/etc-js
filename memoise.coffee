
memory = {}
functions = new WeakMap
export default ($F)->###!IMPORT###
do($F)->###!SCRIPT###
module.exports = ($F)->###!REQUIRE###
	$F::memoise = ->
		return functions.get @ if functions.has @
		base = @
		fn = $F (args...)->
			rec = [@, args...].reduce(
				(data, arg)->
					data.wm ?= new WeakMap
					data.m ?= new Map
					return data.wm.get arg if data.wm.has arg
					return data.m.get arg if data.m.has arg
					next = {}
					try
						data.wm.set arg, next
					catch
						data.m.set arg, next
					next
				, memory
			)
			throw rec.e if 'e' in rec
			return rec.v if 'v' in rec
			try
				rec.v = base.apply @, args
			catch e
				throw rec.e = e
		functions.set @, fn
		fn
	$F.memoise = ->(@ @).memoise()
	@
