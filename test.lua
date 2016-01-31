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
debug('Class', Class)
debug('ClassInstance', ClassInstance)
debug('ClassInstance.name', ClassInstance.name)
debug('ClassInstance.grettings()', ClassInstance.grettings())

local newClassInstance = newClass:create()
newClassInstance.name = 'newClassInstance'
debug('newClassInstance', newClassInstance)
debug('newClassInstance.name', newClassInstance.name)
debug('newClassInstance.grettings()', newClassInstance.grettings())

