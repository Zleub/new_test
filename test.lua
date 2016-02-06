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
	operand = { 'x', 'y' ,'expression'},
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

function A(t, max)

   local l = 1
   local reg = {}
   while l < max do
	  print(l)

	  for i,v in ipairs(t) do
		 if test[v] then
			reg[i] = reg[i] or iter(test[v])
			print( reg[i](true) )
		 end
	  end
	  l = l + 1
   end

end

A(test.expression, 12)
