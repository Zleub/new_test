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
	operand = { 'x', 'y' },
	expression = { 'operand', 'binop', 'operand' }
}

function iter(t, max)
	local i = 0
	local max = max or #t
	return function ()
		i = i + 1
		max = max - 1
		if i > #t then i = 1 end
		if max < 0 then return nil end
		return t[i]
	end
end

function iteri(t, max)
	local i = 0
	local max = max or #t
	return function ()
		i = i + 1
		max = max - 1
		if i > #t then i = 1 end
		if max < 0 then return nil end
		return i, t[i]
	end
end

function apply(t)

	local reg = {}

	function maker(i, e)
		if test[e] then reg[i] = reg[i] or iter(test[e]) end

		return reg[i]
	end

	function consumer(f)
		f()
	end

	function __apply(i, e)
		print( maker(i, e)() )
	end

	for i,v in iteri(t, 9) do
		__apply(i, v)
	end
end

-- local tmp = {}

-- function apply(t, lvl)
-- 	if not lvl then lvl = 0 end
-- 	if lvl > 2 then return end

-- 	for v in iter(t, 10) do

-- 		if type(v) == 'table' then apply(v, lvl)
-- 		elseif type(v) == 'string' then

-- 			if test[v] then

-- 				tmp[v] = tmp[v] or iter(test[v])

-- 				for i=0,lvl do io.write('  ') end
-- 				print( tmp[v]() )
-- 			end
-- 		end

-- 		-- apply(t, lvl + 1)
-- 	end

-- end

apply(test.expression)
