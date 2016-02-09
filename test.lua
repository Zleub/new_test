local inspect = require 'libs.inspect'

function debug(...)
	if ({...})[1] == nil then print('nil') end

	for i,v in ipairs({...}) do
		print(inspect(v))
	end
end

-- local Class = require 'libs.Class'
-- Class.name = 'Class'
-- debug('Class', Class)

-- local newClass = Class:expand()
-- newClass.name = 'newClass'
-- debug('newClass', newClass)

-- local ClassInstance = Class:create()
-- ClassInstance.name = 'ClassInstance'
-- debug('ClassInstance', ClassInstance)

-- local newClassInstance = newClass:create()
-- newClassInstance.name = 'newClassInstance'
-- debug('newClassInstance', newClassInstance)

local test = {
	binop = { '+', '-', '*', '/' },
	operand = { 'x', 'y' , 'expression'},
	expression = { 'operand', 'binop', 'operand' }
}

function iter(t)
	local i = 0
	local j = 1
	local rg = {}

	return function (opt)
		i = i + 1
		if i > #t then
			i = 1
			j = j + 1
			if j > #t then j = 1 end
		end

		local v = t[j]

		if test[v] then
			rg[j] = rg[j] or iter(test[v])
			return rg[j]
		end
		-- if opt then i = i + 1 end


		return v
	end
end

function toto(t)
	local i = 0
	local rg = {}

	return function (opt)
		i = i + 1
		if i > #t then
			i = 1
		end

		local v = t[i]

		if test[v] then
			rg[i] = rg[i] or iter(test[v])
			return rg[i]
		end
		-- if opt then i = i + 1 end


		return v
	end
end

function call(it, max, str, lvl)
	lvl = lvl or 1
	str = str or ""

	local v = it()

	if lvl > max then print('max') return str end

	if type(v) == 'string' then
		return v--..call(it, max, str, lvl + 1)
	elseif type(v) == 'function' then
		-- local var = call(v, max, "", lvl)
		return v()..call(it, max, str, lvl + 1)
	end

	return str
end

print( call( toto(test.expression), 42 ) )

