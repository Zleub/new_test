--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:QuadList
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-20 02:09:11
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-13 14:58:06
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local QuadList = {}

function QuadList.create(config, image)
	local i, j = 0, 0
	local q = { [0] = image }
	local w, h = image:getDimensions()

	while j < h do
		i = 0
		while i < w do
			table.insert(q, love.graphics.newQuad(i, j, config.grid.width + config.spacing.width, config.grid.height + config.spacing.height,
					w, h))
			i = i + config.grid.width + config.spacing.width
		end
		j = j + config.grid.height + config.spacing.height
	end

	return q
end

function QuadList.toCanvasList(config, quadlist)
	local canvaslist = {
		screen = config.screen
	}
	local canvas = love.graphics.newCanvas(config.grid.width, config.grid.height)

	love.graphics.setCanvas(canvas)
	for i,v in ipairs(quadlist) do
		love.graphics.clear()
		love.graphics.draw(quadlist[0], quadlist[i])

		local d = Drawable:create( love.graphics.newImage(canvas:newImageData()) )
		d.scale = config.screen.width / d.image:getWidth()

		table.insert(canvaslist, d)
	end
	love.graphics.setCanvas()

	return canvaslist
end

return QuadList
