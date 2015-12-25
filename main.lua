--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:19:42
-- :ddddddddddhyyddddddddddd: Modified: 2015-12-25 02:31:59
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

inspect = require 'libs.inspect'

function debug(...)
	if ({...})[1] == nil then print('nil') end

	for i,v in ipairs({...}) do
		print(inspect(v))
	end
end

Class = require 'libs.Class'
Drawable = require 'libs.Drawable'
Asset = require 'libs.Asset'

local img1, ext1 = 'hyptosis_tile-art-batch-1', '.png'

local img = Drawable.create( Asset.load(img1, ext1) )
local img2 = Drawable.create( Asset.load(img1, ext1) )

local scale = 1
local x, y = 0, 0
function love.wheelmoved(x, y)
	if y > 0 then
		scale = scale + math.sqrt(scale)
	else
		scale = scale - math.sqrt(scale)
	end
	if scale <= 1 then scale = 1 end
end

function love.keypressed(key)

end

function love.load()
end

function love.update(dt)
	if love.keyboard.isDown('up') then y = y - scale end
	if love.keyboard.isDown('down') then y = y + scale end
	if love.keyboard.isDown('left') then x = x - scale end
	if love.keyboard.isDown('right') then x = x + scale end
	-- img:update(dt)
end

function love.draw()
	img:draw(scale, x, y)
	img2:draw(scale, x, y)
	love.graphics.print(scale)
end
