--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:QuadList
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-20 02:09:11
-- :ddddddddddhyyddddddddddd: Modified: 2015-12-24 03:41:33
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Class = require 'libs.Class'
local QuadList = Class:expand()

function QuadList.create(config, image)
	local i, j = 0, 0
	local q = {}
	local w, h = image:getDimensions()

	while j < h do
		i = 0
		while i < w do
			table.insert(q,
				love.graphics.newQuad(i, j, config.width, config.height,
					w, h))
			i = i + config.width
		end
		j = j + config.height
	end

	-- q.images = {}
	-- local canvas = love.graphics.newCanvas(tileset.width, tileset.height)
	-- love.graphics.setCanvas(canvas)

	-- for i,v in ipairs(q) do
	-- 	canvas:clear()
	-- 	love.graphics.draw(q[0], q[i])
	-- 	local img = love.graphics.newImage(canvas:getImageData())
	-- 	img:setFilter('nearest')
	-- 	table.insert(q.images, img)
	-- end

	-- love.graphics.setCanvas()

	return q
end

return QuadList
