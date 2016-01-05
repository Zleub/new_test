--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:19:42
-- :ddddddddddhyyddddddddddd: Modified: 2016-01-05 18:43:50
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

inspect = require 'libs.inspect'

function clamp(num, min, max)
	if num < min then return min
	elseif num > max then return max
	else return num end
end

function debug(...)
	if ({...})[1] == nil then print('nil') end

	for i,v in ipairs({...}) do
		print(inspect(v))
	end
end

Class = require 'libs.Class'
Drawable = require 'libs.Drawable'
Asset = require 'libs.Asset'
Color = require 'libs.Color'

UI = require 'libs.ui'
Theme = require 'Theme'

Dictionnary = {}
Loader = require 'libs.Loader'
State = require 'libs.State'

local scale = 4

function love.wheelmoved(x, y)
	State:wheelmoved(x, y)
end

function love.keypressed(key)
end

function love.load()
	State('Loading')
	Loader:push( Asset.load, 'hyptosis_tile-art-batch-1', 'png' )
	Loader:push( Asset.load, 'hyptosis_tile-art-batch-2', 'png' )
	UI.registerEvents()
end

function love.update(dt)
	State:update(dt)
end

function love.draw()
	State:draw()
end
