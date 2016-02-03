local inspect = require 'libs.inspect'

function debug(...)
	if ({...})[1] == nil then print('nil') end

	for i,v in ipairs({...}) do
		print(inspect(v))
	end
end

local Class = require 'libs.Class'
Class.name = 'Class'
debug('Class', Class)

local newClass = Class:expand()
newClass.name = 'newClass'
debug('newClass', newClass)

local ClassInstance = Class:create()
ClassInstance.name = 'ClassInstance'
debug('ClassInstance', ClassInstance)

local newClassInstance = newClass:create()
newClassInstance.name = 'newClassInstance'
debug('newClassInstance', newClassInstance)
