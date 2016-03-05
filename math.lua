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

function Character.name(name)
	local f = Function(name)
	return function () f() end
end

function Character:create(name)
	self = Class.create(Character)

	self.name(name)

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

local q = Character:create('Qwerty')
local a = Character:create('Azerty')

print( CharactertoString(q) )
print( CharactertoString(a) )

function Mod(Class)
	debug(Class)
end

Mod(Character)
