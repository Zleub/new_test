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

----
-- name: CanvasBatch
-- namespace:
-- description: This is a standard construction of the Drawable type.
-- extendedDescription:
-- arguments:
-- returns: "Drawable"
-- tags: "v0.0", "Drawable", "needCare", "CanvasBatch"
-- examples: "CanvasBatch:create(f, w, h)"

local CanvasBatch = Drawable:expand()

----
-- name: create_from_function
-- namespace: CanvasBatch
-- description: This function create a Drawable of W * H and apply an function for filling.
-- extendedDescription:
-- arguments: "function", "width", "height"
-- returns:
-- tags: "v0.0", "needCare", "CanvasBatch"
-- examples:

function CanvasBatch:create_from_function(f, width, height)
	local canvas = love.graphics.newCanvas(width, height)

	love.graphics.setCanvas(canvas)
	f(width, height)
	love.graphics.setCanvas()

	local d = Drawable:create( love.graphics.newImage( canvas:newImageData() ) )

	return d
end

----
-- name: create
-- namespace: CanvasBatch
-- description: Standard Selector Constructor
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "CanvasBatch"
-- examples: "CanvasBatch:create(function, number, number)"

function CanvasBatch:create(...)
	return definitions_solver(self, {
		['_'] = function (...) debug('CanvasBatch solver', ...) end,
		['function, number, number'] = CanvasBatch.create_from_function,
	}, ...)
end

return CanvasBatch
