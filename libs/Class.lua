--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Class
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:25:16
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-14 22:01:14
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Class = {}

----
-- name: Class
-- namespace:
-- description: This is the standard Class module.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Class"
-- examples: "local Module = Class:expand()"

Class.name = 'Class'

----
-- name: grettings
-- namespace: Class
-- description: This is the standard grettings function
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Class"
-- examples: "Something:grettings()"

function Class.grettings()
	print('Class.grettings')
end

----
-- name: __index
-- namespace: Class
-- description: This is the Class __index metamethod, allowing inheritance by metatable.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Class", "Metatable"
-- examples:

function Class.__index(t, k)
		return getmetatable(t)[k]
	end

----
-- name: type
-- namespace: Class
-- description: The standard type function for the Class inheritance tree.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Class", "needCare"
-- examples: "Something:type()"

function Class:type()
	return self.name
end

----
-- name: type_iter
-- namespace: Class
-- description: The standard type iterator function for the Class inheritance tree.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Class", "needCare"
-- examples: "for t in Something:type_iter do ... end"

function Class:type_iter()
	local s = self

	return function ()
		if s == nil then return end

		local t = s:type()
		s = getmetatable(s)
		return t
	end
end

----
-- name: dump
-- namespace: Class
-- description: The standard debug function.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Class"
-- examples: "Something:dump()"

function Class.dump(self)
	debug(self)
end

----
-- name: expand
-- namespace: Class
-- description: The standard function for prototyping.
-- extendedDescription: This function take a table as an argument and returns a new table with the paramter as a metatable.
-- arguments: "baseClass"
-- returns: "newClass"
-- tags: "v0.0", "Class", "Metatable"
-- examples: "newClass = Class:expand()", "newC = newClass:expand()"

function Class.expand(baseClass)
	local new = {}

	baseClass.__index = Class.__index

	setmetatable(new, baseClass)
	return new
end

----
-- name: create
-- namespace: Class
-- description: The standard function to create an instance to a class.
-- extendedDescription: This function take a table as an argument and return a shallow copy of that table.
-- arguments: "baseClass"
-- returns: "newInstance"
-- tags: "v0.0", "Class", "Metatable"
-- examples: "s = Something:create()"

function Class.create(baseClass)
	local new = {}

	for k,v in pairs(baseClass) do
		new[k] = v
	end

	setmetatable(new, getmetatable(baseClass))

	return new
end

return Class
