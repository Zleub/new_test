--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Class
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:25:16
-- :ddddddddddhyyddddddddddd: Modified: 2016-01-31 18:11:10
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local inspect = require 'libs.inspect'

local Class = {}

function Class.grettings()
	print('Class.grettings')
end

function Class.dump(self)
	debug(self)
end

function Class.expand(baseClass)
	local new = {}

	baseClass.__index = function (t, k)
		return getmetatable(t)[k]
	end

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
