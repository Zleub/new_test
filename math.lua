inspect = require 'exts.inspect'

Class = require 'libs.Class'
require 'libs.Lib'

math.randomseed( os.time() )

function Range(min, max)
	local value = max
	return function (v)
		if not v then return value / max
		elseif min < v and v < max then value = v
		else print('exception') end
	end
end

function Function(...)
	local args = {...}

	return function ()
		return table.unpack( args )
	end
end

local Character = Class:expand()

function Character:create(name)
	self = Class.create(Character)

	self.name = Function(name)

	self.life = Range(0, 10)

	self.attack = Function( math.random(1, 5) )
	self.defense = Function(3)

	return self
end

function CharactertoString(Character)
	return Character.name()..':\n'
	..'\tlife: '..Character.life()..'\n'
	..'\tattack: '..Character.attack()..'\n'
	..'\tdefense: '..Character.defense()
end

metatable = {
	__call = function (t, size, ...)
		print(size)
		for i=1,size do
			io.write(({...})[i])
			if i ~= size then io.write(' ') end
		end
		io.write('\n')
	end,
	__index = function (a, b, c)
		debug(a,b,c)
	end
}

local NMatrix = {}
setmetatable(NMatrix, metatable)

local m = NMatrix(4, 0, 0, 0, 0)

debug( NMatrix[42] )
