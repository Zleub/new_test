--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Class
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:25:16
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-13 14:50:52
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Class = {}

function Class.grettings()
	print('Class.grettings')
end

function Class.__index(t, k)
		return getmetatable(t)[k]
	end

function Class.type()
	return 'Class'
end

function Class.dump(self)
	debug(self)
end

function Class.expand(baseClass)
	local new = {}

	baseClass.__index = Class.__index

	setmetatable(new, baseClass)
	return new
end

function Class.create(baseClass)
	local new = {}

	for k,v in pairs(baseClass) do
		new[k] = v
	end

	setmetatable(new, getmetatable(baseClass))

	return new
end

return Class
