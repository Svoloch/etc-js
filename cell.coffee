
export default ($F)->###!IMPORT###
do($F)->###!SCRIPT###
module.exports = ($F)->###!REQUIRE###
	$F::cell = (params...)->
		current = @
		value = null
		changed = false
		destroyed = false
		do recalc = ->
			throw new current.Error() if destroyed
			changed = false
			value = current (for param in params then do param)...
		res = @constructor.prototype(-> unless changed then value else do recalc)
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
		res = @prototype (newValue)->
			if arguments.length
				if value != newValue
					value = newValue
					for related in res.relateds
						do related.markChange
			value
		res.relateds = []
		res.recalc = -> value
		res
