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

function iter(t)
	local i = 1
	return function (opt)
		local v = t[i]

		if opt then i = i + 1 end
		if i > #t then i = 1 end
		return v
	end
end

local f = iter(test.expression)

print( f() )
print( f(true) )
print( f() )
