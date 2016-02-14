--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:CanvasBatch
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-14 21:09:50
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-14 21:31:33
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local CanvasBatch = Drawable:expand()

function CanvasBatch:create_from_function(f, width, height)
	local canvas = love.graphics.newCanvas(width, height)

	love.graphics.setCanvas(canvas)
	for i=0, width - 1, Dictionnary['hyptosis_tile-art-batch-1'].screen.width do
		for j=0, height - 1, Dictionnary['hyptosis_tile-art-batch-1'].screen.height do

			f(i, j)

		end
	end
	love.graphics.setCanvas()

	local d = Drawable:create( love.graphics.newImage( canvas:newImageData() ) )

	return d
end

function CanvasBatch:create(...)
	return definitions_solver(self, {
		['_'] = function (...) debug('CanvasBatch solver', ...) end,
		['function, number, number'] = CanvasBatch.create_from_function,
	}, ...)
end

return CanvasBatch
