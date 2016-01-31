--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:QuadList
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-20 02:09:11
-- :ddddddddddhyyddddddddddd: Modified: 2016-01-31 18:06:47
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Class = require 'libs.Class'
local QuadList = Class:expand()

function QuadList.create(config, image)
	local i, j = 0, 0
	local q = { [0] = image }
	local w, h = image:getDimensions()

	while j < h do
		i = 0
		while i < w do
			table.insert(q, love.graphics.newQuad(i, j, config.width, config.height,
					w, h))
			i = i + config.width
		end
		j = j + config.height
	end

	return q
end

return QuadList
